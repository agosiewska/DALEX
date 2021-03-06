% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/explain.R
\name{explain.default}
\alias{explain.default}
\alias{explain}
\title{Create Model Explainer}
\usage{
explain.default(model, data = NULL, y = NULL,
  predict_function = NULL, residual_function = NULL, ...,
  label = NULL, verbose = TRUE, precalculate = TRUE)

explain(model, data = NULL, y = NULL, predict_function = NULL,
  residual_function = NULL, ..., label = NULL, verbose = TRUE,
  precalculate = TRUE)
}
\arguments{
\item{model}{object - a model to be explained}

\item{data}{data.frame or matrix - data that was used for fitting. If not provided then will be extracted from the model. Data should be passed without target column (this shall be provided as the \code{y} argument). NOTE: If target variable is present in the \code{data}, some of the functionalities my not work properly.}

\item{y}{numeric vector with outputs / scores. If provided then it shall have the same size as \code{data}}

\item{predict_function}{function that takes two arguments: model and new data and returns numeric vector with predictions}

\item{residual_function}{function that takes three arguments: model, data and response vector y. It should return a numeric vector with model residuals for given data. If not provided, response residuals (\eqn{y-\hat{y}}) are calculated.}

\item{...}{other parameters}

\item{label}{character - the name of the model. By default it's extracted from the 'class' attribute of the model}

\item{verbose}{if TRUE (default) then diagnostic messages will be printed}

\item{precalculate}{if TRUE (default) then \code{predicted_values} and \code{residual} are calculated when explainer is created.
This will happen also if \code{verbose} is TRUE. Set both \code{verbose} and \code{precalculate} to FALSE to omit calculations.}
}
\value{
An object of the class \code{explainer}.

It's a list with following fields:

\itemize{
\item \code{model} the explained model
\item \code{data} the dataset used for training
\item \code{y} response for observations from \code{data}
\item \code{y_hat} calculated predictions
\item \code{residuals} calculated residuals
\item \code{predict_function} function that may be used for model predictions, shall return a single numerical value for each observation.
\item \code{residual_function} function that returns residuals, shall return a single numerical value for each observation.
\item \code{class} class/classes of a model
}
}
\description{
Black-box models may have very different structures.
This function creates a unified representation of a model, which can be further processed by various explainers.
}
\details{
Please NOTE, that the \code{model} is the only required argument.
But some explainers may require that other arguments will be provided too.
}
\examples{
# simple explainer for regression problem
aps_lm_model4 <- lm(m2.price ~., data = apartments)
aps_lm_explainer4 <- explain(aps_lm_model4, data = apartments, label = "model_4v")
aps_lm_explainer4

# various parameters for the explain function
# all defaults
aps_lm <- explain(aps_lm_model4)

# silent execution
aps_lm <- explain(aps_lm_model4, verbose = FALSE)

# user provided predict_function
aps_lm <- explain(aps_lm_model4, data = apartments, label = "model_4v", predict_function = predict)

# set target variable
aps_lm <- explain(aps_lm_model4, data = apartments, label = "model_4v", y = apartments$m2.price)
aps_lm <- explain(aps_lm_model4, data = apartments, label = "model_4v", y = apartments$m2.price,
                                   predict_function = predict)

 \dontrun{
# more complex model
library("randomForest")
aps_rf_model4 <- randomForest(m2.price ~., data = apartments)
aps_rf_explainer4 <- explain(aps_rf_model4, data = apartments, label = "model_rf")
aps_rf_explainer4
 }

}
