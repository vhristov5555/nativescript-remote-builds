
def snakeUpperCase (string)
  return string.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    tr(".", "_").
    upcase
end

def getCLIArgEnvName (argName)
  return "CLI_ARG_" + snakeUpperCase(argName) + "_{{CLI_BUILD_ID}}";
end

def getEnvVar (envVarName)
  result = 
      ENV[snakeUpperCase(envVarName) + "_{{CLI_BUILD_ID}}"] ||
      ENV[snakeUpperCase(envVarName)];

  return result;
end

def getCLIArgsFromEnv (argNames)
  cliArgs = [];
  argNames.each do |argName|
    envVarName = getCLIArgEnvName(argName);
    envVarValue = ENV[envVarName];
    if envVarValue
      if envVarValue == "1"
        cliArgs.push("--#{argName}");
      else
        cliArgs.push("--#{argName}", "\"$#{envVarName}\"");
      end
    end
  end

  return cliArgs;
end