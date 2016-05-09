//
//  NetWorkFetcher.swift
//  QDaily
//
//  Created by song on 4/11/16.
//  Copyright © 2016 song. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class NetWorkFetcher: NSObject {
    let url = "http://app3.qdaily.com/app3/homes/index/0.json"

    func getReleases(done: (model: [TTModel]?) -> ()) {
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let feeds: Array<JSON> = json["response"]["feeds"].arrayValue;
                    var model = [TTModel]()
                    feeds.forEach({ feed in
                        let post = feed["post"];
                        
                        let genre = post["genre"].intValue;
                        var url : String;
                        if (genre == 1001) {
                            url =  "http://www.qdaily.com/mobs/".stringByAppendingFormat("%d.html", post["id"].intValue);
                        } else if (genre == 1000) {
                            url =  "http://www.qdaily.com/papers/".stringByAppendingFormat("%d.html", post["id"].intValue);
                        } else {
                            url = "http://www.qdaily.com/articles/".stringByAppendingFormat("%d.html", post["id"].intValue);
                        }
                        let like:Int32 = post["praise_count"] != nil ? post["praise_count"].int32! : 0;
                        let comment:Int32 = post["comment_count"] != nil ? post["comment_count"].int32! : 0;
                        model.append(TTModel(
                            title: post["title"].stringValue,
                            url: url,
                            href: url,
                            like: like,
                            comment: comment
                            ));
                    })
                    done(model: model);
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}
