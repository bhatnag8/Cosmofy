import SwiftUI
#if !os(tvOS)
import WebKit

#endif

var today = ""
var done = false

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }


    public var image: Image
    public var caption: String
}

#if !os(tvOS)
struct IOTDView: View {
    @ObservedObject var viewModel = ViewModelAPOD()


//    @State private var fetched: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var selectedDate: Date = Date()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .padding()
                            .foregroundStyle(.red)
                    } else if let apod = viewModel.apod {
                        VStack {
                            VStack(spacing: 8) {
                                VStack {
                                    HStack {
                                        Text("Astronomy Picture of the Day")
                                            .font(Font.system(size: 16))
                                            .textCase(.uppercase)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                    .onAppear() {
                                        
                                    }
                                    Divider()
                                        .tint(.secondary)
                                }
                                
                                VStack {
                                    HStack {
                                        Text(apod.title)
                                            .font(Font.system(size: 42))
                                            .bold()
                                            .fontWidth(.compressed)
                                        Spacer()
                                    }
                                    HStack {
                                        Text(convertDateString(dateString: apod.date))
                                            .italic()
                                            .font(.body)
                                            .fontDesign(.serif)
                                        Spacer()
                                    }
                                }
                            }
                            .padding()
                            
                            #if os(tvOS)
                            if apod.media_type == "image" {
                                ImageView(apod.url)
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            } else if apod.media_type == "video" {
                                VStack {
                                    Text("Video content cannot be displayed on Watch. Please view it on your iPhone.")
                                        .padding()
                                        .font(.caption2)
                                        .foregroundStyle(.red)
                                }
                                .padding()
                            }
                            #else
                            
                            if apod.media_type == "video" {
                                if (apod.url != nil) {
                                    WebView(urlString: apod.url!)
                                        .frame(height: 300)
                                        .padding(.horizontal)
                                }
                                
                            } else {
                                if apod.hdurl != nil {
                                    ImageView(apod.hdurl!)
                                        .padding(.horizontal)
                                } else {
                                    if (apod.url != nil) {
                                        ImageView(apod.url!)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                            #endif
                            
                            if !apod.explanation.isEmpty {
                                VStack {
                                    HStack {
                                        Text("a brief explanation")
                                            .font(Font.system(size: 16))
                                            .textCase(.uppercase)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                    Divider()
                                        .tint(.secondary)
                                }
                                .padding([.top, .horizontal])
                                
                                Text(apod.explanation)
                                    .italic()
                                    .font(.body)
                                    .fontDesign(.serif)
                                    .padding(.horizontal)
                            }
                        }
                    } else {
                        ProgressView("Loading...")
                            .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        in: dateRange,
                        displayedComponents: .date
                    )
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: selectedDate) { oldDate, newDate in
                        print("Original selectedDate (UTC): \(oldDate)")
                        print("Original selectedDate (UTC): \(newDate)")

                        // Convert the selected date to Eastern Time Zone

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        let dateString = dateFormatter.string(from: newDate)
                        print("Formatted Date String: \(dateString)")
                        viewModel.fetch(for: dateString)
                    }
                    .tint(.SOUR)
                }
            }
        }
    }
    
    var dateRange: ClosedRange<Date> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let minDate = dateFormatter.date(from: "1995-06-16")!
        // Get the current date and time
       let currentDate = Date()
       
       // Convert the current date to the EST time zone
       let estTimeZone = TimeZone(abbreviation: "EST")!
       var calendar = Calendar.current
       calendar.timeZone = estTimeZone
       let estDate = calendar.startOfDay(for: currentDate)
        print(estDate)
        return minDate...estDate
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
#endif


// View for displaying images
struct ImageView: View {
    @ObservedObject var imageLoader = ImageLoader()
    @State private var isSaved = false
    @State private var buttonColor: Color = .indigo
    @State private var text = "Download"
    @State private var imageIcon = "arrow.down.to.line"
    let viewModel = ViewModelAPOD()
    init(_ url: String) {
        self.imageLoader.load(url)

    }
    var body: some View {
        if let image = imageLoader.downloadedImage {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .aspectRatio(contentMode: .fill)
                #if os(iOS)
                HStack {
                    Button {
                        UIImageWriteToSavedPhotosAlbum(imageLoader.downloadedImage!, nil, nil, nil)
                        // Animate and change the button color on success
                        withAnimation {
                            isSaved = true
                            buttonColor = .green // Change button color on success
                            text = "Saved to Gallery"
                            imageIcon = "checkmark.seal.fill"
                        }
                        // Reset the state after a short delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isSaved = false
                                buttonColor = .indigo // Reset button color
                                text = "Download"
                                imageIcon = "arrow.down.to.line"
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(text)
                                .padding(.vertical)
                                .fontDesign(.rounded)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Image(systemName: imageIcon)
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                                .padding(.vertical)
                            Spacer()
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(buttonColor)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    
//                    Button {
//                        let photo = Photo(image: Image(uiImage: imageLoader.downloadedImage!), caption: "Image")
//                        ShareLink(item: photo, preview: SharePreview(photo.caption, image: photo.image))
//                    } label: {
//                        Image(systemName: "square.and.arrow.up")
//                            .foregroundStyle(.secondary)
//                            .fontWeight(.medium)
//                    }
//                    .frame(width: 50, height: 50)
//                    .background(Color.gray.opacity(0.2))
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    ShareLink(item: Photo(image: Image(uiImage: imageLoader.downloadedImage!), caption: "Astronomy Picture of the Day"), preview: SharePreview(Photo(image: Image(uiImage: imageLoader.downloadedImage!), caption: "Astronomy Picture of the Day").caption, image: Photo(image: Image(uiImage: imageLoader.downloadedImage!), caption: "").image)) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
//                    Button {
//
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .foregroundStyle(.secondary)
//                            .fontWeight(.medium)
//                    }
//                    .frame(width: 50, height: 50)
//                    .background(Color.gray.opacity(0.2))
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "chevron.right")
//                            .foregroundStyle(.secondary)
//                            .fontWeight(.medium)
//                    }
//                    .frame(width: 50, height: 50)
//                    .background(Color.gray.opacity(0.2))
//                    .clipShape(RoundedRectangle(cornerRadius: 16))

                }
                .padding(.top, 8)
                
                #endif

            }
        } else {
            VStack {
                ProgressView("Loading...")
                    .padding()
            }
            .frame(height: 400)

        }
    }
}

func subtractOneDay(from dateString: String) -> String? {
    // Create a DateFormatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert the string to a Date
    guard let date = dateFormatter.date(from: dateString) else {
        return nil // Return nil if the conversion fails
    }
    
    // Use Calendar to subtract one day
    let calendar = Calendar.current
    if let newDate = calendar.date(byAdding: .day, value: -1, to: date) {
        // Convert the new Date back to String
        return dateFormatter.string(from: newDate)
    }
    
    return nil
}
func addOneDay(from dateString: String) -> String? {
    // Create a DateFormatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert the string to a Date
    guard let date = dateFormatter.date(from: dateString) else {
        return nil // Return nil if the conversion fails
    }
    
    // Use Calendar to subtract one day
    let calendar = Calendar.current
    if let newDate = calendar.date(byAdding: .day, value: +1, to: date) {
        // Convert the new Date back to String
        return dateFormatter.string(from: newDate)
    }
    
    return nil
}


#if !os(tvOS)

struct WebView: UIViewRepresentable {
    
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Leave this empty for now
    }
}

#endif

struct WordByWordTextView: View {
    let fullText: String
    let animationInterval: TimeInterval
    @State private var displayedText: String = ""
    private let words: [String]
    
    init(_ text: String, interval: TimeInterval = 0.35) {
        self.fullText = text
        self.animationInterval = interval
        self.words = text.split { $0.isWhitespace }.map(String.init)
    }
    
    var body: some View {
        HStack {
            Text(displayedText)
                .onAppear {
                    if displayedText == "" {
                        DispatchQueue.main.async {
                            self.animateText()
                        }
                    }
                }
            Spacer()
        }
    }
    
    private func animateText() {
        var currentWordIndex = 0
        Timer.scheduledTimer(withTimeInterval: animationInterval, repeats: true) { timer in
            if currentWordIndex < words.count {
                let word = words[currentWordIndex]
                displayedText += (currentWordIndex == 0 ? "" : " ") + word
                currentWordIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

func convertDateString(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = dateFormatter.date(from: dateString) else {
        return "Invalid date"
    }
    
    dateFormatter.dateStyle = .full
    return dateFormatter.string(from: date)
}

