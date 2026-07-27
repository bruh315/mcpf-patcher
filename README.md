### mcpf patcher tool
this tool is made to patch Minecraft jar files for modding purposes
and avoiding copyright issue's (from redistributing the JARs)

### WARNING: YOU CANNOT PUBLISH ANY JARS/FILES GENERATED
### USING THIS TOOL IF THE INPUT JARS WERE COPYRIGHTED!

The patching format:
 version=URL installs the specified jar and unzips it into dir ./src
 del=PATH deletes the file specified by parameter PATH
 rem=PATH removes the directory specified by parm PATH
 patch=PATH=URL patches a file PATH with the output of curling URL
 output=VN=URL creates a minecraft version folder (%appdata%\.minecraft\versions\VN)
 ZIPs the JAR into there and downloads a JSON MF file from URL and cleans up SRC
