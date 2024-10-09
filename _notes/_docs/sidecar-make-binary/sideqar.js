const command = process.argv[2];

switch (command) {
  case 'ping':
    const message = process.argv[3];
    console.log(`pong, ${message}`);
    break;
  case 'regex':
    const argRegex = new RegExp(process.argv[4],process.argv[5])
    const matched = `${process.argv[3]}`.match(argRegex)
    console.log(`matched regex: ${matched}`)
    break;
  default:
    console.error(`unknown command ${command}`);
    process.exit(1);
}
