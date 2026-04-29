library(readr)

churn_data <- read_csv("data/churn_modeling.csv")

churn_data <- churn_data[, c("Geography", "Exited")]

churn_data$Exited <- factor(churn_data$Exited)

exit_status_summary <- table(churn_data$Geography, churn_data$Exited)

exit_status_percentage <- prop.table(exit_status_summary, margin = 1) * 100

png('images/churn_chart.png', width = 7, height = 5, units = "in", res=400)

barplot(
  t(exit_status_percentage),
  col = c("#569DDA", "#E6A4B4"),
  legend.text = c("Not Exited", "Exited"),
  main = "Customer Churn Distribution by Geography",
  xlab = "Country",
  ylab = "Percentage (%)",
  names.arg = rownames(exit_status_summary),
  ylim = c(0, 100)
)

dev.off()

chisq.test(exit_status_summary)
