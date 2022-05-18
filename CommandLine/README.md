# Command Line

## Basics

- [Command Line Basics](/command-line-basics.md)

## sed 

- [https://jhnyang.tistory.com/137](https://jhnyang.tistory.com/137)

```
sed -n "1, 2p" old_file > new_file
echo "${new_body}" >> new_file
sed -n "3, \$p" old_file >> new_file

cat new_file > old_file
```
