import XCTest
@testable import NetworkPlatform

class NewsApiParsingTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testJSONDecoding() throws {
        let data = try readFileData(fileName: "NewsApiResponse")
        let result = try JSONDecoder().decode(NAPostsContainer.self, from: data)
        XCTAssertEqual(result, makeNAPostsContainerStub())
    }
    
    func testRssDecoding() throws {
        let data = try readFileData(fileName: "LentaResponse", ofType: "xml")
        let decoder = RssDecoderImpl()
        let result = try decoder.decode(data: data)
        XCTAssertEqual(result, makeRssChanelStub())
    }
    
    func makeRssChanelStub() -> RssChannel {
        let chanel = RssChannel()
        chanel.language = "ru"
        chanel.title = "Lenta.ru : Новости"
        chanel.description = "Новости, статьи, фотографии, видео. Семь дней в неделю, 24 часа в сутки."
        chanel.link = "https://lenta.ru"
        let chanelImage = RssChanelImage()
        chanelImage.url = "https://lenta.ru/images/small_logo.png"
        chanelImage.title = "Lenta.ru"
        chanelImage.link = "https://lenta.ru"
        chanelImage.width = 134
        chanelImage.height = 22
        chanel.image = chanelImage
        let post = RssPost()
        post.guid = "https://lenta.ru/news/2022/01/11/tochkaq/"
        post.author = "Дмитрий Настасьев"
        post.title = "Советник Назарбаева назвал слабое место в Казахстане"
        post.link = "https://lenta.ru/news/2022/01/11/tochkaq/"
        post.description = "\n    На фоне массовых беспорядков в Казахстане бывший советник первого президента республики Нурсултана Назарбаева Ермухамет Ертысбаев назвал юг страны «слабым местом» для проникновения и ударов боевиков. Мнением Ертысбаев поделился в разговоре с российским журналистом Владимиром Соловьевым.\n  "
        post.pubDate = "Tue, 11 Jan 2022 19:09:37 +0300"
        post.category = "Бывший СССР"
        let postEnclosure = RssEnclosure()
        postEnclosure.url = "https://icdn.lenta.ru/images/2022/01/11/18/20220111185024470/pic_103329fa3ca2d8df93f7b219b8a70595.jpeg"
        post.enclosure = postEnclosure
        chanel.items.append(post)
        return chanel
    }
    
    func makeNAPostsContainerStub() -> NAPostsContainer {
        let post = NAPost(
            source: .init(
                id: nil,
                name: "Business Today"
            ),
            author: "Prerna Lidhoo",
            title: "Why the Mahindra-SsangYong partnership didn’t work out",
            description: "Mahindra-owned SsangYong Motor is finally sold to South Korean electric bus and truck maker Edison Motors. But why did M&M’s much-hyped partnership fail?",
            content: "Debt-ridden SsangYong Motor is finally acquired by a local consortium led by South Korean electric bus and truck maker Edison Motors for 305 billion Won ($254.56 million). According to the companys r… [+3914 chars]",
            url: "https://www.businesstoday.in/auto/story/why-the-mahindra-ssangyong-partnership-didnt-work-out-318698-2022-01-11",
            urlToImage: "https://akm-img-a-in.tosshub.com/businesstoday/images/story/202201/ezgif-sixteen_nine_117.jpg",
            publishedAt: "2022-01-11T16:11:30Z"
        )
        let containter = NAPostsContainer(posts: [post])
        return containter
    }
}
