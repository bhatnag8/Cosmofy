import SwiftUI
import WebKit


var today = ""
var done = false

struct IOTDView: View {
    @ObservedObject var viewModel = ViewModelAPOD()
    @State private var fetched: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var selectedDate: Date = Date()

    var body: some View {
        NavigationStack {
            VStack {
                if showDatePicker {
                    DatePicker("Select Date", selection: $selectedDate, in: dateRange, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .onChange(of: selectedDate) { oldDate, newDate in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let dateString = dateFormatter.string(from: newDate)
                            viewModel.fetch(for: dateString)
                            showDatePicker.toggle()
                        }
                        .tint(.SOUR)
                        .animation(.easeInOut, value: showDatePicker)
                }
                
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
                                            .onAppear(perform: {
                                                if !done {
                                                    today = viewModel.apod!.date
                                                    done = true
                                                }})
                                        Spacer()
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
                            
                            if apod.media_type == "video" {
                                WebView(urlString: apod.url)
                                    .frame(height: 300)
                                    .padding(.horizontal)
                            } else {
                                ImageView(apod.url)
                                    .padding(.horizontal)
                            }
                            
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
            .navigationBarItems(trailing: Button(action: {
                selectedDate = convertStringToDate(dateString: viewModel.apod?.date ?? "")
                withAnimation {
                    showDatePicker.toggle()
                }
            }) {
                Image(systemName: "calendar.badge.plus")
                    .imageScale(.large)
            })
            .onAppear {
                if !fetched {
                    viewModel.fetch()
                    fetched = true
                }
            }
        }
    }
    
    var dateRange: ClosedRange<Date> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let minDate = dateFormatter.date(from: "1995-06-16")!
        let maxDate = dateFormatter.date(from: today)!
        return minDate...maxDate
    }
}

func convertStringToDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter.date(from: dateString) ?? Date()
}

// View for displaying images
struct ImageView: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    init(_ url: String) {
        self.imageLoader.load(url)
    }
    
    var body: some View {
        if let image = imageLoader.downloadedImage {
            Image(uiImage: image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView("Loading...")
                .padding()
        }
    }
}



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

