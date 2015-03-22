if (!file.exists("./data")) {
        dir.create("./data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
destFile <- "./data/restaurants.csv"
download.file(fileUrl, destfile = destFile, method = "curl")
restData <- read.csv(destFile)
head(restData, 3)
tail(restData, 3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = T, probs=c(.5,.75,.9))
quantile(restData$councilDistrict, na.rm = T)
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(is.na(restData$councilDistrict) > 0)
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213")) # OR operation
restData[restData$zipCode %in% c("21212", "21213"),]
xtabs(councilDistrict ~ zipCode, data=restData)
data(warpbreaks)
warpbreaks$replicate <- rep(1:9, len=54)
xt <- xtabs(breaks~.,data=warpbreaks)
xt
fxt <- ftable(xt)
class(fxt)
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups, restData$zipCode)
install.packages("Hmisc")
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode,g=5)
table(restData$zipGroups)
restData$zcf <- as.factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
mtcars$carname <- rownames(mtcars)
install.packages("reshape2")
library(reshape2)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"), measure.vars=c("mpg","hp"))
carMelt
View(carMelt)
View(mtcars)

#################################################
## Quiz 3
urlText <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(urlText, destfile = "commsurvey.csv", method = "curl")
commsurvey <- read.csv("commsurvey.csv")

# Question 1
commsurveyNew <- mutate(commsurvey, agricultureLogical = (AGS == 6 & ACR == 3))
which(commsurveyNew$agricultureLogical) # 125, 238, 262

# Question 2
install.packages("jpeg")
library(jpeg)
urlImg <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(urlImg, destfile="jtleek.jpg", method="curl")
img <- readJPEG("jtleek.jpg", native = T)
quantile(img, probs=c(.3,.8)) # -15259150 -10575416

# Question 3
urlTextGDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
urlTextEd <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(urlTextGDP, destfile = "gdp.csv", method = "curl")
download.file(urlTextEd, destfile = "edu.csv", method = "curl")
gdp <- read.csv("gdp.csv", stringsAsFactors=F, header = F, skip=5, nrows=190)
edu <- read.csv("edu.csv", stringsAsFactors=F)
sum(unique(gdp$V1) %in% unique(edu$CountryCode)) # 189 matches
joined <- left_join(gdp, edu, by = c("V1" = "CountryCode"))
joined2 <- arrange(joined, desc(V2))
joined3 <- mutate(joined2, index = seq_along(V1)) # St. Kitts & Nevis

# Question 4
hioecd <- filter(joined3, Income.Group == "High income: OECD")
hinonoecd <- filter(joined3, Income.Group == "High income: nonOECD")
mean(hioecd$V2,na.rm = T) # 32.96667
mean(hinonoecd$V2,na.rm = T) # 91.91304

#Question 5
install.packages("Hmisc")
library(Hmisc)
gdpcuts <- mutate(joined3, range=cut2(joined3$V2, g=5))
nrow(gdpcuts %>% filter(Income.Group == "Lower middle income" & range == levels(gdpcuts$range)[1])) # 5