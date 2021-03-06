% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prediction_breakdown.R
\name{prediction_breakdown}
\alias{prediction_breakdown}
\alias{single_prediction}
\title{Calculate Break Down Explanations}
\usage{
prediction_breakdown(explainer, observation, ...)
}
\arguments{
\item{explainer}{a model to be explained, preprocessed by the 'explain' function}

\item{observation}{a new observarvation for which predictions need to be explained}

\item{...}{other parameters that will be passed to \code{breakDown::broken.default()}}
}
\value{
An object of the class 'single_prediction_explainer'.
It's a data frame with calculated average response.
}
\description{
This function is set deprecated. It is suggested to use \code{\link[iBreakDown]{break_down}} instead.
Find information how to use these functions here: \url{https://pbiecek.github.io/PM_VEE/breakDown.html}.
}
\examples{
new_dragon <- data.frame(year_of_birth = 200,
     height = 80,
     weight = 12.5,
     scars = 0,
     number_of_lost_teeth  = 5)

dragon_lm_model4 <- lm(life_length ~ year_of_birth + height +
                                     weight + scars + number_of_lost_teeth,
                       data = dragons)
dragon_lm_explainer4 <- explain(dragon_lm_model4, data = dragons, y = dragons$year_of_birth,
                                label = "model_4v")
dragon_lm_predict4 <- prediction_breakdown(dragon_lm_explainer4, observation = new_dragon)
head(dragon_lm_predict4)
plot(dragon_lm_predict4)

\dontrun{
library("randomForest")
dragon_rf_model4 <- randomForest(life_length ~ year_of_birth + height +
                                               weight + scars + number_of_lost_teeth,
                                 data = dragons)
dragon_rf_explainer4 <- explain(dragon_rf_model4, data = dragons, y = dragons$year_of_birth,
                                label = "model_rf")
dragon_rf_predict4 <- prediction_breakdown(dragon_rf_explainer4, observation = new_dragon)
head(dragon_rf_predict4)
plot(dragon_rf_predict4)

library("gbm")
# create a gbm model
model <- gbm(life_length ~ year_of_birth + height + weight + scars +
                           number_of_lost_teeth, data = dragons,
             distribution = "gaussian",
             n.trees = 1000,
             interaction.depth = 4,
             shrinkage = 0.01,
             n.minobsinnode = 10,
             verbose = FALSE)
 # make an explainer for the model
 explainer_gbm <- explain(model, data = dragons, predict_function =
         function(model, x) predict(model, x, n.trees = 1000))
 # create a new observation
 exp_sgn <- prediction_breakdown(explainer_gbm, observation = new_dragon)
 head(exp_sgn)
 plot(exp_sgn)

 exp_sgn <- prediction_breakdown(explainer_gbm, observation = new_dragon, baseline = 0)
 plot(exp_sgn)
 }

}
\references{
Predictive Models: Visual Exploration, Explanation and Debugging \url{https://pbiecek.github.io/PM_VEE/}
}
