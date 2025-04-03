library(ghibli)
library(tidyr)
library(ggplot2)
library(tidyverse)
library(ggpubr)

# Load the data from your CSV file
df <- read.csv("D:/FYP_Figures/FYP_metadata.csv")

# Reorder levels of Group variable
df$Group <- factor(df$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Define custom order for Group variable
custom_order <- c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case")

# Reorder the levels of Group variable
df$Group <- factor(df$Group, levels = custom_order)

# Subset the data for Premenopause Control and Premenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", c("Raw", "Clean", "HG_trimmed")]
premenopause_case_data <- df[df$Group == "Premenopause Case", c("Raw", "Clean", "HG_trimmed")]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", c("Raw", "Clean", "HG_trimmed")]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", c("Raw", "Clean", "HG_trimmed")]

# Combine the data for visualization for all groups
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "Raw", Value = premenopause_control_data$Raw),
  data.frame(Group = "Premenopause Case", Variable = "Raw", Value = premenopause_case_data$Raw),
  data.frame(Group = "Postmenopause Control", Variable = "Raw", Value = postmenopause_control_data$Raw),
  data.frame(Group = "Postmenopause Case", Variable = "Raw", Value = postmenopause_case_data$Raw),
  
  data.frame(Group = "Premenopause Control", Variable = "HG trimmed", Value = premenopause_control_data$HG_trimmed),
  data.frame(Group = "Premenopause Case", Variable = "HG trimmed", Value = premenopause_case_data$HG_trimmed),
  data.frame(Group = "Postmenopause Control", Variable = "HG trimmed", Value = postmenopause_control_data$HG_trimmed),
  data.frame(Group = "Postmenopause Case", Variable = "HG trimmed", Value = postmenopause_case_data$HG_trimmed),
  
  data.frame(Group = "Premenopause Control", Variable = "Clean", Value = premenopause_control_data$Clean),
  data.frame(Group = "Premenopause Case", Variable = "Clean", Value = premenopause_case_data$Clean),
  data.frame(Group = "Postmenopause Control", Variable = "Clean", Value = postmenopause_control_data$Clean),
  data.frame(Group = "Postmenopause Case", Variable = "Clean", Value = postmenopause_case_data$Clean)
)

# Reorder the levels of Variable
combined_data$Variable <- factor(combined_data$Variable,
                                 levels = c("Raw", "Clean", "HG trimmed"))

# Reorder the levels of Group variable in combined_data
combined_data$Group <- factor(combined_data$Group, levels = custom_order)

# Create separate plots for Raw, HG_trimmed, and Clean using facet_wrap
ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  geom_violin(scale = "width", trim = FALSE, draw_quantiles = NULL) +
  geom_boxplot(width = 0.08, fill = "gray", position = position_dodge(width = 0.9), alpha = 0.7) +  
  
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2",
                               "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF"),
                    breaks = custom_order) + # Specify the custom order
  labs(title = "Reads distribution in different groups",
       x = NULL,
       y = "Read Count (millions)",
       fill = "Group") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 12, face = "bold"),
    strip.placement = "outside",
    plot.margin = margin(1, 1, 1, 1, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

