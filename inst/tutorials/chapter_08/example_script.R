first_ten <- 1:10
first_ten

first_five <- 1:5
print(first_five) # Print the first_five vector

mean_fn <- function(x) {
  sum(x) / length(x)
}

mean_vec <- mean_fn(first_five + first_ten)
mean_vec