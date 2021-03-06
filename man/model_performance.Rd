% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_performance.R
\name{model_performance}
\alias{model_performance}
\title{Calculate Model Performance}
\usage{
model_performance(explainer, ...)
}
\arguments{
\item{explainer}{a model to be explained, preprocessed by the \code{\link{explain}} function}

\item{...}{other parameters}
}
\value{
An object of the class \code{model_performance_explainer}.
}
\description{
Prepare a data frame with model residuals.
}
\examples{
 \dontrun{
library("randomForest")
HR_rf_model <- randomForest(as.factor(status == "fired")~., data = HR, ntree = 100)
explainer_rf  <- explain(HR_rf_model, data = HR, y = HR$status == "fired")
# resulting dataframe has predicted values and residuals
model_performance(explainer_rf)

HR_glm_model <- glm(status == "fired"~., data = HR, family = "binomial")
explainer_glm <- explain(HR_glm_model, data = HR, y = HR$status == "fired",
                    predict_function = function(m,x) predict.glm(m,x,type = "response"))
mp_ex_glm <- model_performance(explainer_glm)
mp_ex_glm
plot(mp_ex_glm)

HR_lm_model <- lm(status == "fired"~., data = HR)
explainer_lm <- explain(HR_lm_model, data = HR, y = HR$status == "fired")
model_performance(explainer_lm)
 }

}
\references{
Predictive Models: Visual Exploration, Explanation and Debugging \url{https://pbiecek.github.io/PM_VEE/}
}
