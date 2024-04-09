

<p align="center" >  
<img src="https://uddoktapay.com/assets/images/logo.png">  
</p>  
<h1 align="center">UddoktaPay Payment Gateway Flutter Package By Programming Wormhole</h1>  
<p align="center" >  
</p>  


[![Pub](https://img.shields.io/pub/v/flutter_bkash.svg)](https://pub.dev/packages/uddoktapay)  
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)  
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)]() [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()  
[![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)]()


<p align="center" >  
<img src="https://yt3.googleusercontent.com/Cdmgizpu7QU94Rc9uWbUUO9IXt9F8FZ1Dx_vAslp7quJEdy13I1DMcKQBDnumDrTk4KTHNci8Gg=w1060-fcrop64=1,00005a57ffffa5a8-k-c0xffffffff-no-nd-rj">  
</p>  


This is a [Flutter package](https://pub.dev/packages/uddoktapay) for [UddoktaPay](https://uddoktapay.com) Payment Gateway. This package can be used in flutter project. Programming Wormhole was created this package while working for a project and thought to release for all so that it helps.

> :warning: Please note that, you have to contact with UddoktaPay sales team for any kind of dev or production access keys. We don't provide any test account or access keys or don't contact us for such.

Check the package in <a target="_blank" href="https://github.com/programmingwormhole/uddoktapay" rel="noopener">github</a> and also available in <a href="https://pub.dartlang.org/packages/uddoktapay" rel="noopener nofollow" target="_blank">flutter/dart package</a>

[![Facebook](https://img.shields.io/badge/Facebook-%231877F2.svg?logo=Facebook&logoColor=white)](https://facebook.com/no.name.virus) [![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?logo=Instagram&logoColor=white)](https://instagram.com/no.name.virus) [![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mdshirajulislam-dev) [![YouTube](https://img.shields.io/badge/YouTube-%23FF0000.svg?logo=YouTube&logoColor=white)](https://youtube.com/@programmingwormhole)

## How to use:
Depend on it, Run this command With Flutter:
```  
$ flutter pub add uddoktapay  
```  
This will add a line like this to your package's `pubspec.yaml` (and run an implicit **`flutter pub get`**):
```  
dependencies:  
uddoktapay: ^0.0.2 
```  
Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more. Import it, Now in your Dart code, you can use:
```  
import 'package:uddoktapay/uddoktapay.dart';  
import 'package:uddoktapay/models/customer_model.dart';  
```  
## Features
- Pay using UddoktaPay

## Usage
Official Link for API documentation and demo checkout
- [UddoktaPay API Documentation](https://uddoktapay.readme.io/reference/overview)

### Make a Payment

***Sandbox***
```  
UddoktaPay.createPayment(  
    context: context,  
    customer: CustomerDetails(  
    fullName: 'Programming Wormhole',  
    email: 'programmingwormhole@icloud.com',  
    ),  
    amount: '50',  
);  
```  
***Production***
```  
UddoktaPay.createPayment(  
    context: context,  
    customer: CustomerDetails(  
    fullName: 'Programming Wormhole',  
    email: 'programmingwormhole@icloud.com',  
    ),  
    amount: '50',  
    credentials: UddoktapayCredentials(  
    apiKey: 'api_key',  
    panelURL: 'https://pay.domain.com',  
    ),  
)  
```  
> Make sure to replace the provided credentials with your own UddoktaPay production credentials.

***Response***
```  
final response = await UddoktaPay.createPayment(  
    ....  
    ....  
)  
```  

***Response Sample***
```  
RequestResponse(  
    fullName: "Programming Wormhole",  
    email: "programmingwormhole@icloud.com",  
    amount: "50.00","fee":"0.00",  
    chargedAmount: "50.00",  
    invoiceId: "a19Aun0gPxIqBVjnCfpL",  
    paymentMethod: "bkash",  
    senderNumber: "675675656765",  
    transactionId: "FGHGFHJGHG",  
    date: "2024-04-09 12:01:28",  
    status: ResponseStatus.completed,  
);  
```  
### Error Handling
The methods mentioned above may throw a `status`. You can catch and handle the status using a if-else block:
```  
if (response.status == ResponseStatus.completed) {  
    // handle on complete  
}  
  
if (response.status == ResponseStatus.canceled) {  
    // handle on cancel  
}  
  
if (response.status == ResponseStatus.pending) {  
    // handle on pending  
}  
```  

Examples for see the `/example` folder.

**Here is the example code** [link](https://github.com/programmingwormhole/uddoktapay/blob/master/example/lib/main.dart)

**Example Video Demo**

<div align="center">  
<video src="https://github.com/programmingwormhole/uddoktapay/raw/master/demo.mp4" controls></video>  
</div>  


### Importance Notes
- Read the comments in the example of code
- See the documents [UddoktaPay API Documentation](https://uddoktapay.readme.io/reference/overview)


## Contributing
**Core Maintainer**
- [Md Shirajul Islam](https://github.com/programmingwormhole)

Contributions to the **uddoktapay** package are welcome. Please note the following guidelines before submitting your pull request.

- Follow [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) coding standards.
- Read UddoktaPay API documentations first.Please contact with UddoktaPay for their api documentation and sandbox access.

## License

Uddoktapay package is licensed under the [BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause).

Copyright 2024 [Programming Wormhole](https://programmingwormhole.com). We are not affiliated with UddoktaPay and don't give any guarantee.