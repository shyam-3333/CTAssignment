@isTest
global class EyewearMockHttpResponseGenerator implements HttpCalloutMock{
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        
        res.setHeader('Content-Type', 'application/json');
        Date todayDate = System.today();
        todayDate = todayDate.addDays(-1);
        String day = todayDate.day()<=9?'0'+String.valueOf(todayDate.day()):String.valueOf(todayDate.day());
        String month = todayDate.month()<=9?'0'+String.valueOf(todayDate.month()):String.valueOf(todayDate.month());
        String year = String.valueOf(todayDate.year());
        String folderName = day+'_'+month+'_'+year;     
        System.debug(req.getEndpoint());
        if(req.getEndpoint() == 'callout:Proposal_Tool_Eyewear/eyeware?list-type=2&max-keys=1&prefix=Production/recentProductExport_'+folderName+'&delimiter=/'){
            String body = '<?xml version="1.0" encoding="UTF-8"?>';
            body+= '<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">';
            body+='<Name>eyeware</Name>';
            body+='<Prefix>Production/recentProductExport_08_04_2022</Prefix>';
            body+='<KeyCount>1</KeyCount>';
            body+='<MaxKeys>1</MaxKeys>';
            body+='<Delimiter>/</Delimiter>';
            body+='<IsTruncated>false</IsTruncated>';
            body+='<Contents>';
            body+='<Key>Production/recentProductExport_08_04_20221647226803.csv</Key>';
            body+='<LastModified>2022-03-13T21:36:17.000Z</LastModified>';
            body+='<ETag>&quot;8aee6820ad72fba910b93010eb71b04b&quot;</ETag>';
            body+='<Size>4862780</Size>';
            body+='<StorageClass>STANDARD</StorageClass>';
            body+='</Contents>';
            body+='</ListBucketResult>';
            res.setBody(body);
        }else if(req.getEndpoint()=='callout:Proposal_Tool_Eyewear/eyeware/Production/recentProductExport_08_04_20221647226803.csv'){
            String body =  '';
            //body+='Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,"Wallets, Bags","Wallets, Bags","Wallets, Bags","Wallets, Bags","Bags, Belts","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets",Belts,Belts,Belts,Belts,Belts,"Belts, Wallets","Belts, Wallets","Belts, Wallets","Belts, Wallets","Belts, Wallets",Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,"Watches, Bags, Fragrances",Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common';
            body+='sku,attribute_set_name,name,sap_sku_id,brand,categories,description,aplus_content,face_shape,acc_bridge_width,acc_front_shape,acc_lens_height,acc_lens_width,acc_size,acc_size_clip,frame_color_code,frame_design,frame_face_shape,frame_front_shape,frame_front_shape_label,frame_front_styling,frame_gender,frame_international,frame_lifestyle,frame_material,frame_material_desc,frame_parent_model,frame_size,frame_size_number,frame_type,frame_weight_without_lens,frame_weight_without_lens_no,front_color,front_color_user,front_color_user_sunglass,front_colour_pattern,front_finish,front_material_details,front_material_user,front_size,bestseller,new,sale,collection,contactlens_validity,country_of_manufacture,disposable,price,tax_class_id,thumbnail,url_key,url_path,virtual_tryon,virtual_try_on,images,updated_at,final_price';
            body+='\nSTT67CG,Lens,STT67CG,STT67CG,Titan,,,,,,,,,,,,,,,,,,No,,,,,,,,,,,,,,,,,,No,No,No,,," ",,14199.000000,"Lens VAT/CST",https://admin.titaneyeplus.com/,https://admin.titaneyeplus.com/stt67cg,,No,No,,"2022-03-09 11:47:49",14199';
            body+='\nLTT67CG,Lens,LTT67CG,LTT67CG,Titan,,,,,,,,,,,,,,,,,,No,,,,,,,,,,,,,,,,,,No,No,No,,," ",,18499.000000,"Lens VAT/CST",https://admin.titaneyeplus.com/,https://admin.titaneyeplus.com/ltt67cg,,No,No,,"2022-03-09 09:08:21",18499';
            res.setBody(body);
        }else if(req.getEndpoint() == 'callout:Proposal_Tool_Eyewear/eyeware?list-type=2&max-keys=1&prefix=Production/priceTableExport_24_04_2022&delimiter=/'){
            String body = '<?xml version="1.0" encoding="UTF-8"?>';
            body+= '<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">';
            body+='<Name>eyeware</Name>';
            body+='<Prefix>Production/priceTableExport_24_04_2022</Prefix>';
            body+='<KeyCount>1</KeyCount>';
            body+='<MaxKeys>1</MaxKeys>';
            body+='<Delimiter>/</Delimiter>';
            body+='<IsTruncated>false</IsTruncated>';
            body+='<Contents>';
            body+='<Key>Production/priceTableExport_24_04_20221647226803.csv</Key>';
            body+='<LastModified>2022-03-13T21:36:17.000Z</LastModified>';
            body+='<ETag>&quot;8aee6820ad72fba910b93010eb71b04b&quot;</ETag>';
            body+='<Size>4862780</Size>';
            body+='<StorageClass>STANDARD</StorageClass>';
            body+='</Contents>';
            body+='</ListBucketResult>';
            res.setBody(body);
        }else if(req.getEndpoint()=='callout:Proposal_Tool_Eyewear/eyeware/Production/priceTableExport_24_04_20221647226803.csv'){
            String body =  '';
            //body+='Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Watches,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,Bags,"Wallets, Bags","Wallets, Bags","Wallets, Bags","Wallets, Bags","Bags, Belts","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets","Bags, Belts, Wallets",Belts,Belts,Belts,Belts,Belts,"Belts, Wallets","Belts, Wallets","Belts, Wallets","Belts, Wallets","Belts, Wallets",Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Wallets,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,Fragrances,"Watches, Bags, Fragrances",Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Merchandising,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Sunglasses,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common,Common';
            body+='sku, normal_price, final_price';
            body+='\nTest,100,100';
            body+='\nTest1,100,100';
            res.setBody(body);
        }
        
        
        res.setStatusCode(200);
        return res;
    }
    
}