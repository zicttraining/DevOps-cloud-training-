# In Terraform, local variables are defined using the 'locals' block. They allow you to store static or dynamically manipulated data within your configuration. Here is an example of how to define a local variable in Terraform:
```
locals {
  cat_sound = "meow"
}
```

#### In this example, a local variable named 'cat_sound' is defined with the value "meow". Local variables can be used to store information that you want to refer to multiple times within a module without repeating the expression. It's important to use local variables judiciously to avoid making the code hard to read and maintain.

