Sys.setenv(LANG = "en") # change R language to English!

library("mlr3")
library("plumber")  

# loading the model globally for using the classifier 
model<-get(load("DENV5F_AS.rda"))

### PLUMBER ANOTATIONS
#  prediction function
#* @get /mypredict
#* @serializer unboxedJSON
#* @apiTitle Plasma leakage prediction model
#* @apiDescription This is a machine learning model for early prediction of plasma leakage developed as part of the research by R.Z. Marandi, et al. 2022, and is currently intended to be used for research purposes only. Please refer to the following paper titled "Development of a machine learning model for early prediction of plasma leakage in suspected dengue patients" for further information. To use this API, click on "GET" followed by "try it out" and you can insert values for 5 variables as predictors. The model receives the following variables as input: Age in years, Haemoglobin in g/dL, Haematocrit in %, Lymphocyte count in kilo/microL, and AST in U/L. It returns PL for plasma leakage or noPL for none.
#* @apiContact list(name = "API Support", email = "ramtin.zargari.marandi@regionh.dk")
#* @apiLicense list(name = "The GNU General Public License v3.0", url = "https://www.gnu.org/licenses/gpl-3.0.en.html")
#* @apiVersion 1.0.1
mypredict<-function(HCT,HGB,AST,Lymphocyte_count,Age){
  
  newdata=data.frame(
    HCT=as.numeric(HCT),
    HGB=as.numeric(HGB),
    AST=as.numeric(AST),
    Lymphocyte_count=as.numeric(Lymphocyte_count),
    Age=as.numeric(Age)
  )
  
  prediction<-predict(model,newdata)
  return(list(class=prediction))
}

