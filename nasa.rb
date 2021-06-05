require "uri"
require "net/http"
require "json"

def request(address, api_key="4xHTrO9aLMCMhzMtwCjg6tyBbyGj06k3ZqfLFMhU")
    url = URI("#{address}&api_key=#{api_key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    JSON.parse response.read_body.to_str
end

body = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")

def build_web_page(body)
    #Create file html
    File.open("index.html", "w") do |html|
    #Write html top
    html.write('<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NASA - Image Gallery</title>
    <meta name="author" content="María A">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
        integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/721059713c.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Titillium+Web:wght@400;700&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="assets/img/logo.png" alt="NASA">      
                <a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Home<span class="sr-only">(current)</span></a></li>
                <li class="nav-item">
                    <a class="nav-link" href="#gallery">Gallery</a></li>
                <li class="nav-item">
                    <a class="nav-link" href="#socialmedia">Contact</a></li>
            </ul>
        </div>
    </nav>
    <section id="gallery">
        <div class="container-fluid text-center">
            <div>
                <h1 class="container-fluid text-center">NASA - Image Gallery</h1>
                <h4>Find the latest pictures taken by Mars Curiosity.</h4>
                <h5>This is a rover designed to assess whether Mars ever had an environment able to support small life forms called microbes.</h5>
                <h5>Its mission is to determine the planets habitability.</h5>
            </div>
            <div class="row">
            ')
        
    #Write html middle list
    images=[]
    26.times do |i|
        images.push body["photos"][i]["img_src"]
    end

    list=images.size #Equal to 26 elements
    list.times do |e|
        html.write("\t<div class='col-lg-4'><img src='#{images[e]}' class='rounded'></div>\n\t\t\t")
    end

    #Write html bottom
    html.write("</div>
        </div>
    </section>    
    <footer id=socialmedia class='container-fluid'>
        <div class='row'>
            <div class='col-md-6 text-right>'>
                <p>National Aeronautics and Space Administration, 2021. Follow and be a part of the conversation on popular social media sites with NASA.</p>
            </div>
            <div class='col-md-6 text-center'>
                <a href='https://twitter.com/nasa'data-toggle='tooltip' data-placement='top' title='Twitter'>
                    <i class='fab fa-twitter-square fa-3x'></i></a>
                <a href='https://www.facebook.com/NASA/'data-toggle='tooltip' data-placement='top' title='Facebook'>
                    <i class='fab fa-facebook-square fa-3x'></i></a>
                <a href='https://www.instagram.com/NASA/'data-toggle='tooltip' data-placement='top' title='Instagram'>
                <i class='fab fa-instagram-square fa-3x'></i></a>
            </div>
        </div>
    </footer>
</body>
    <script src='https://code.jquery.com/jquery-3.6.0.js'
        integrity='sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=' crossorigin='anonymous'></script>
    <script src='https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js'
        integrity='sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN' crossorigin='anonymous'>
    </script>
    <script src='https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js'
        integrity='sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF' crossorigin='anonymous'>
    </script>
    <script src='assets/js/script.js'></script>")
    end
end

build_web_page(body)