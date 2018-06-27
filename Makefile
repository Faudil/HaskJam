##
## ./Makefile for FUN
##
## Made by Tanguy Gérôme
##        <me@kapno.cc>
##      on Tue Jun 26 16:31:41 2018
##

NAME	= FUN

RM	= rm -f

SRCS	= \
	  app/Main.hs \
	  src/Lib.hs\

FILES	= $(SRCS) \
	  Makefile \
	  stack.yaml \
	  package.yaml \

$(NAME): $(FILES)
	stack build
	cp `stack exec which $(NAME)-exe` $(NAME)

all:	$(NAME)

clean:
	stack clean $(NAME)

fclean:	clean
	$(RM) $(NAME)

re:	fclean all
