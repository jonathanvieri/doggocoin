# DoggoCoin

<p align="left">
  <img src="https://github.com/jonathanvieri/doggocoin/blob/main/images/applogo.png" width="150" height="150">
</p>

DoggoCoin is a simple cryptocurrency price checking app, specifically for Dogecoin.  

This project is made to demonstrate the usage of API Call and JSON Parsing in Storyboard.  
The app can be extended by adding recent prices, max/min price for the day, etc.  
The app can also be modified to check for other cryptocurrency price.  


## Screenshots 
<p>
  <img src="https://github.com/jonathanvieri/doggocoin/blob/main/images/DoggoCoinExample1.png" height="350">
  &emsp;&emsp;
  <img src="https://github.com/jonathanvieri/doggocoin/blob/main/images/DoggoCoinExample2.png" height="350">
</p>


## Features
* Get the latest price of Dogecoin in real-time
* Change between 21 different currencies


## Technical
* Created using Storyboard
* MVC design pattern
* Delegate pattern to fetch the latest price
* API Call using URLSession and JSONParsing using Codable protocol
* Change between different currencies using Picker View


## Usage
1.  Clone the project
2.  Fill the API Key in Constants file
3.  Open and run the project in XCode


## Credits
Crypto pricing data is provided by [Nomics](https://nomics.com/)


## License
This project is licensed under the [MIT License](https://github.com/jonathanvieri/doggocoin/blob/master/LICENSE)
