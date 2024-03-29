require 'spec_helper'

describe "BeermappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("tampere")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("O'Connell's Irish Bar")
    expect(place.street).to eq("Rautatienkatu 24")
  end

  it "When HTTP GET returns nothing an empty array is returned" do

    canned_answer = <<-END_OF_STRING
<?xml version="1.0" encoding="UTF-8"?>
<bmp-locations>
  <location>
    <id nil="true"/>
    <name nil="true"/>
    <status nil="true"/>
    <reviewlink nil="true"/>
    <proxylink nil="true"/>
    <blogmap nil="true"/>
    <street nil="true"/>
    <city nil="true"/>
    <state nil="true"/>
    <zip nil="true"/>
    <country nil="true"/>
    <phone nil="true"/>
    <overall nil="true"/>
    <imagecount nil="true"/>
  </location>
</bmp-locations>
    END_OF_STRING

    stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("tampere")

    expect(places).to eq([])
  end

  it "When HTTP GET returns many an array is returned" do

    canned_answer = <<-END_OF_STRING
<?xml version="1.0" encoding="UTF-8"?>
<bmp-locations>
  <location type="array">
    <location>
      <id>6742</id>
      <name>Pullman Bar</name>
      <status>Beer Bar</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=6742</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=6742&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=6742&amp;d=1&amp;type=norm</blogmap>
      <street>Kaivokatu 1</street>
      <city>Helsinki</city>
      <state nil="true"/>
      <zip>00100</zip>
      <country>Finland</country>
      <phone>+358 9 0307 22</phone>
      <overall>72.500025</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>6743</id>
      <name>Belge</name>
      <status>Beer Bar</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=6743</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=6743&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=6743&amp;d=1&amp;type=norm</blogmap>
      <street>Kluuvikatu 5</street>
      <city>Helsinki</city>
      <state nil="true"/>
      <zip>00100</zip>
      <country>Finland</country>
      <phone>+358 10 766 35</phone>
      <overall>67.499925</overall>
      <imagecount>1</imagecount>
    </location>
    <location>
      <id>6919</id>
      <name>Suomenlinnan Panimo</name>
      <status>Brewpub</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=6919</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=6919&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=6919&amp;d=1&amp;type=norm</blogmap>
      <street>Rantakasarmi</street>
      <city>Helsinki</city>
      <state nil="true"/>
      <zip>00190</zip>
      <country>Finland</country>
      <phone>+358 9 228 5030</phone>
      <overall>69.166625</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>12408</id>
      <name>St. Urho's Pub</name>
      <status>Beer Bar</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12408</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=12408&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=12408&amp;d=1&amp;type=norm</blogmap>
      <street>Museokatu 10</street>
      <city>Helsinki</city>
      <state nil="true"/>
      <zip>00100</zip>
      <country>Finland</country>
      <phone>+358 9 5807 7222</phone>
      <overall>95</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>12409</id>
      <name>Kaisla</name>
      <status>Beer Bar</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12409</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=12409&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=12409&amp;d=1&amp;type=norm</blogmap>
      <street>Vilhonkatu 4</street>
      <city>Helsinki</city>
      <state nil="true"/>
      <zip>00100</zip>
      <country>Finland</country>
      <phone>+358 10 76 63850</phone>
      <overall>83.3334</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>12410</id>
      <name>Pikkulintu</name>
      <status>Beer Bar</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12410</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=12410&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=12410&amp;d=1&amp;type=norm</blogmap>
      <street>Klaavuntie 11</street>
      <city>Helsinki</city>
      <state nil="true"/>
      <zip>00910</zip>
      <country>Finland</country>
      <phone>+358 9 321 5040</phone>
      <overall>91.6667</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>18418</id>
      <name>Bryggeri Helsinki</name>
      <status>Brewpub</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18418</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=18418&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=18418&amp;d=1&amp;type=norm</blogmap>
      <street>Sofiankatu 2</street>
      <city>Helsinki</city>
      <state nil="true"/>
      <zip>FI-00170</zip>
      <country>Finland</country>
      <phone>010 235 2500</phone>
      <overall>0</overall>
      <imagecount>0</imagecount>
    </location>
  </location>
</bmp-locations>
    END_OF_STRING

    stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("tampere")

    expect(places.size).to eq(7)
    expect(places[0].name).to eq('Pullman Bar')
    expect(places[6].name).to eq('Bryggeri Helsinki')
  end

end