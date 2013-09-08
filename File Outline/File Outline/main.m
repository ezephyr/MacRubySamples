//
//  main.m
//  File Outline
//
//  Created by Geoff Shannon on 9/7/13.
//  Copyright (c) 2013 Geoff Shannon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
