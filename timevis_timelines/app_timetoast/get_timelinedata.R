
# Creation of data frame containing Walt Disney timeline informtion from
# http://www.timetoast.com/timelines/walt-disney-studios-e3c9cdb3-5552-410b-a81f-1934f19444d9

templateTL = function(dir,datechr, txtdetail, txt,imagefilenum){
  
  day = strftime(as.Date(datechr),"%d")
  mon = strftime(as.Date(datechr),"%b")
  yr = strftime(as.Date(datechr),"%Y")
  datetxt = paste0(day," ",mon,", ",yr)
  sprintf('<a href = "%s/image%s.jpg" target = "_blank">
          <img src = "%s/image%s.jpg" width="31" height="20"></a>
          <div style = "color:blue;font-weight:bold">%s</div>
          <div title = "%s">%s</div>
          ',dir,imagefilenum,dir,imagefilenum,datetxt,txtdetail,txt)
}

##---------------Create Walt Disney Pictures timeline dataframe-------------------------
# http://www.timetoast.com/timelines/walt-disney-studios-e3c9cdb3-5552-410b-a81f-1934f19444d9
#

start = c("1923-10-16","1928-11-18","1938-06-02","1940-02-07","1950-07-19","1954-10-27",
          "1955-07-17","1955-10-02","1959-01-29","1964-10-29","1966-12-15","1983-10-15",
          "1986-09-12","1994-06-15"
)
end = rep(NA,length(start))
dir = rep("disneytimeline_html",length(start))

txt = c("Walt Disney Studio is established",
        "Mickey Mouse is born",
        "Disney release their first animated feature",
        "Disney releases pinnochio",
        "Treasure Island is released",
        "Disneyland has its own TV show",
        "The Mickey Mouse clubhouse",
        "Disneyland Opening",
        "Sleeping Beauty is released",
        "Mary Poppins is released",
        "Walt Disney is diagnosed with Lung Cancer",
        "Tokyo Disneyland",
        "Michael Jackson stars in Disney Film",
        "The Lion King"
)

txtdetail = c(
  "Walt Disney studios bought their first office in Los Angeles.",
  "Mickey Mouse is created by Walt Disney and Ub Iwerks",
  "Snow white and the seven dwarfs was released and created an evolution",
  "Pinocchio dominates the screens all around the world",
  "Disney's first non animated film is released to theatres",
  "The Disneyland television series was created by and starred Walt Disney",
  "Disney's second television series The Mickey Mouse Clubhouse is aired",
  "Walt Disney's Disneyland theme park grand opening.",
  "Sleeping Beauty hits theatres and is a huge success",
  "Disney's first ever film to receive an Academy Award for best picture",
  "Walt Disney dies and leaves the world in shock",
  "Tokyo opens their very own Disneyland",
  "Micheal Jackson stars in Disney's Captain EO",
  "The Lion King is released to theatres."
)
content = sapply(1:length(start),function(i) templateTL(dir[i],start[i],txtdetail[i], txt[i], i))

dataWD = data.frame(start = start, end = end, content = content,stringsAsFactors = FALSE)
dataWD2 = data.frame(start = "1940-11-30", end = "1959-01-29", 
                 content = "Disney releases 16 new files from 1940-1959",stringsAsFactors = FALSE)
dataWD = rbind(dataWD,dataWD2)
dataWD$id = 1:nrow(dataWD)

##-------------Create History of Airplanes timeline dataframe--------------------------------
# https://www.timetoast.com/timelines/history-of-airplanes
# made some minor modifications
#

start = c("1903-01-01","1909-01-01","1914-01-01","1915-01-01","1917-01-01",
          "1925-01-01","1930-01-01","1933-01-01","1937-01-01","1938-01-01","1939-01-01",
          "1947-10-14","1949-08-27","1952-01-01","1960-01-01","1963-01-01",
          "1969-01-01","1969-01-01","1986-01-01","1997-01-01","2006-01-01","2009-12-15")

end = rep(NA,length(start))

dir = rep("airplanetimeline_html",length(start))

txt = c("Wright Flyer",
        "Bleriot IX",
        "Gyrostabilizer",
        "The First Fighter Plane",
        "Junker J4",
        "Lightwiegt Aircooled Radial Engines",
        "Jet Engine",
        "Boeing 242",
        "Jet Engines",
        "Boeing 307",
        "Heinkel HE178",
        "Bell X-1",
        "De Havilland DH 106 Comet",
        "Area Rule of Aircraft Design",
        "X-15",
        "Learjet",
        "Boeing 747",
        "Concorde",
        "Voyager",
        "B-2 Spirit",
        "Airbus 380",
        "Boing 787 Dreamliner"
        )

txtdetail = c("The first flight of an object heavier than air commenced in 1903 by the Wright brothers. The distance of 37m.",
              "In 1909 Louis Bleriot invented the the first monoplane called Bleriot IX. Bleriot completed a 36.6km flight from Calais, France to Dover,UK, in 37 minutes.",
              "1914 was the year Lawrence Sperry demonstrates the automatic gyrostabilizer. This kept planes level and flying in a straight line. 2 years later he improved on the gyrostabilizer by adding steering mechanism to create automatic pilot.",
              "French pilot Roland Garros flew the first ever fighter plane. The plane was armed with a machine gun that shot through its propeller. While piloting the fighter plane took down 5 planes.",
              "In the year of 1917 Hugo Junkers built the first all metal plane. The metal was a lightweight aluminum alloy called duralumin.",
              "In 1925 the Lightwieght aircooled radial engines were invented and with them planes can be bigger and faster.",
              "In 1930Frank Whittle patented the turbo the jet engine.",
              "In 1933 Boeing created the boeing 242, the first model airliner. It could carry 10 passengers in comfort. The Boeing 242 was twin engined and was completely metal.",
              "After patenting it 7 years ago, in 1937 Frank Whittle with the help of Hans Von Ohain made the first test runs of the jet engine.",
              "The boeing 307 stratoline was the first fully pressurized plane. This allowed it to fly 6.096 km high. Because it could fly so high it flew above the weather so if there was rough winds they just fly above it and the passengers would have a more comfortable ride.",
              "The heinkel HE178 was the first fully jet powered plane.",
              "The Bell X-I broke the sound barrier on the 14 of October 1947 by Captain 'Chuck' Yeager.",
              "The prototype of the first jet poered airliner takes its first flight. In 1952 it became a regular passenger jet giving a quiet and faster flight.",
              "Richard Whitcomb discovers an aircraft concept known as the Area Rule of Aircraft Design. The concept helps inventors by giving them a basic design that aircrafts need to reduce drag and increase speed without additional power.",
              "The X-15 was created in 1960. It reached the speed of mach 6, it was six times faster than the Bell X-1 which broke the speed barrier 13 years ago.",
              "The Learjet was the first small jet to be mass produced",
              "The Beoing 747 conducts its first flight. It is a widebodied commercial airline. It was the most successful airline ever made.",
              "The invention of the Concorde commenced in 1969. It was the first supersonic airliner with speeds that reached double the speed of sound!",
              "The voyager was the first plane to circumnavigate the globe nonstop in only 9 days, using one tank of fuel. The voyager used a carbon-composite material which makes it lighter.",
              "The B-2 Spirit was the most expensive plane ever made, it cost more than one Billion dollars to build. The B-2 Spirit was a long range bomber so it uses less fuel.",
              "The Airbus 350 is a double decker plane. It is the largest plane built and had enough seats for 555 people.",
              "Boeing 787 Dreamliner"
              )

content = sapply(1:length(start),function(i) templateTL(dir[i],start[i],txtdetail[i], txt[i], i))

dataAP = data.frame(start = start, end = end, content = content,stringsAsFactors = FALSE)
dataAP$id = 1:nrow(dataAP)
