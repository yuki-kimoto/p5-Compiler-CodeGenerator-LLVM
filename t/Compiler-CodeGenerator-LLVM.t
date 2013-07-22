use strict;
use warnings;
use Compiler::Lexer;
use Compiler::Parser;
use Test::More;
BEGIN {
    use_ok('Compiler::CodeGenerator::LLVM');
}

my $code = do { local $/; <DATA> };
my $tokens = Compiler::Lexer->new('')->tokenize($code);
my $parser = Compiler::Parser->new();
my $ast = $parser->parse($tokens);
my $generator = Compiler::CodeGenerator::LLVM->new();
$generator->debug_run($ast);

done_testing;

__DATA__
say 1 + 2 == 3;
say 1.2 + 2.3 == 3.5;
say 2.1 + 2 == 4.1;
say 1 - 2 == -1;
say 1.3 - 2 == -0.7;
say 1.3 * 2 == 2.6;
say 1.3 * -2 == -2.6;
say 1.3 / 2 == 0.65;
say 1.3 / -2 == -0.65;
say 1 != 2;
say 1.2 != 2.4;
say 2 > 1;
say 1 < 2;
