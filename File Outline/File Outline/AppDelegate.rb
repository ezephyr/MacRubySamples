#
#  AppDelegate.rb
#  File Outline
#
#  Created by Geoff Shannon on 9/7/13.
#  Copyright 2013 Geoff Shannon. All rights reserved.
#

class AppDelegate
    
    attr_accessor :window
    
    attr_accessor :fileOutline
    
    def applicationDidFinishLaunching(a_notification)
        source = FileSource.new
        @fileOutline.setDataSource(source)
    end
end

class FileSystemItem
    attr_accessor :relativePath

    def initialize(path, parent)
        @parent = parent
        @relativePath = parent == nil ? path : path.lastPathComponent.copy
        @children = nil
    end

    def children()
        if (@children == nil)

            fullPath = fullPath()
            @children = []

            if (File.exists?(fullPath) && File.directory?(fullPath))
                
                Dir.foreach(fullPath) do |filename|
                    @children << FileSystemItem.new(filename, self)
                end

            end
        end
        return @children
    end

    def numberOfChildren()
        if (children != nil)
            return @children.length
        else
            return -1
        end
    end
    
    def childAtIndex(index)
        if (children != nil)
            return @children[index]
        else
            return nil
        end
    end
    
    def fullPath()
        if (@parent == nil)
            return @relativePath
        end
        return @parent.fullPath.stringByAppendingPathComponent(relativePath)
    end
    
end




class FileSource
    
    @@rootFile = nil
    
    def outlineView(outline, numberOfChildrenOfItem:item)
        return item == nil ? 1 : item.numberOfChildren
    end
    
    def outlineView(outline, isItemExpandable:item)
        return item == nil ? true : item.numberOfChildren != -1
    end
    
    def outlineView(outline, child:index, ofItem:item)
        if (@@rootFile == nil)
            @@rootFile = FileSystemItem.new(File.expand_path("~"), nil)
        end
        return item == nil ? @@rootFile : item.childAtIndex(index)
    end
    
    def outlineView(outline, objectValueForTableColumn:tableColumn, byItem:item)
        return item == nil ? File.expand_path("~") : item.relativePath
    end
    
end