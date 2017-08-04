##################
# Math functions #
##################
#square - Square of a number of any data type
@outputSchemaFunction("squareSchema")
def square(num):
    return ((num)*(num))
@schemaFunction("squareSchema")
def squareSchema(input):
    return input
