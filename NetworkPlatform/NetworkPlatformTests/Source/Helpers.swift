import Foundation
@testable import NetworkPlatform
import Domain

private class A { }

func readFileData(fileName: String, ofType: String = "json") throws -> Data {
    guard
        let path = Bundle(for: A.self).path(forResource: fileName, ofType: ofType),
        let data = NSData(contentsOfFile: path)
    else {
        throw URLError(.badURL)
    }
    return data as Data
}

extension NAPostsContainer {
    static func makeStubAsInFile() -> Self {
        let date = Formatter.yyyyMMddTHHmmssZ.date(from: "2022-01-11T16:11:30Z")!
        let post = NAPost(
            source: .init(
                id: nil,
                name: "Business Today"
            ),
            author: "Prerna Lidhoo",
            title: "Why the Mahindra-SsangYong partnership didn’t work out",
            description: "Mahindra-owned SsangYong Motor is finally sold to South Korean electric bus and truck maker Edison Motors. But why did M&M’s much-hyped partnership fail?",
            content: "Debt-ridden SsangYong Motor is finally acquired by a local consortium led by South Korean electric bus and truck maker Edison Motors for 305 billion Won ($254.56 million). According to the companys r… [+3914 chars]",
            url: URL(string: "https://www.businesstoday.in/auto/story/why-the-mahindra-ssangyong-partnership-didnt-work-out-318698-2022-01-11"),
            urlToImage: URL(string: "https://akm-img-a-in.tosshub.com/businesstoday/images/story/202201/ezgif-sixteen_nine_117.jpg"),
            publishedAt: date
        )
        let containter = NAPostsContainer(posts: [post])
        return containter
    }
}


extension RssChannel {
    static func makeStubAsInFile() -> RssChannel {
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
}


extension PostsContainer {
    static func makeRssContainerStubAsInFile() -> Self {
        let chanel = RssChannel.makeStubAsInFile()
        let rssPost = chanel.items.first!
        let resourceInfo = PostsResourceInfoFactory.lenta
        let id = (try? SHA256().sha(for: rssPost, with: JSONEncoder())) ?? ""
        
        let post = Post(
            id_: id,
            author_: .init(name_: rssPost.author, email_: nil),
            link_: URL(string: rssPost.link!),
            publicationDate_: Formatter.RFC822.date(from: rssPost.pubDate!),
            title_: rssPost.title,
            description_: rssPost.description,
            category_: rssPost.category,
            image_: .init(url_: URL(string: rssPost.enclosure!.url!)),
            sourceId_: resourceInfo.id,
            sourceName_: resourceInfo.name,
            sourceLink_: resourceInfo.url
        )
        
        return .init(
            id_: resourceInfo.id,
            name_: resourceInfo.name,
            image_: .init(url_: URL(string: chanel.image!.url!)),
            url_: resourceInfo.url,
            description_: chanel.description,
            posts_: [post]
        )
    }
    
    static func makeNewApiContainerStubAsInFile() -> Self {
        let naPostContainer = NAPostsContainer.makeStubAsInFile()
        let naPost = naPostContainer.posts.first!
        let resourceInfo = PostsResourceInfoFactory.newsApi
        
        let id = (try? SHA256().sha(for: naPost, with: JSONEncoderFactory.yyyyMMddDateSupportEncoder)) ?? ""
        
        let post = Post(
            id_: id,
            author_: .init(name_: naPost.author, email_: nil),
            link_: naPost.url,
            publicationDate_: naPost.publishedAt,
            title_: naPost.title,
            description_: naPost.description,
            category_: nil,
            image_: .init(url_: naPost.urlToImage),
            sourceId_: resourceInfo.id,
            sourceName_: resourceInfo.name,
            sourceLink_: resourceInfo.url
        )
        
        return .init(
            id_: resourceInfo.id,
            name_: resourceInfo.name,
            image_: nil,
            url_: resourceInfo.url,
            description_: nil,
            posts_: [post]
        )
    }
}
