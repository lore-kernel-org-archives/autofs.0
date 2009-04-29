From: Ian Kent <raven@themaw.net>
Subject: Re: Which version to uses, nsswitch.conf parse errors
Date: Wed, 29 Apr 2009 09:59:51 +0800
Message-ID: <49F7B497.80006@themaw.net>
References: <20090428201219.GC6042@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090428201219.GC6042@gmx.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
Cc: autofs@linux.kernel.org

Marc Weber wrote:
> Hi at all,
> 
> I'd like to add some automount support to the nixos linux distribution.
> however I don't know exactly which version to I should use?
> 
> automount v5 (autfs4 kernel module (?)) or automount v4?

Version 5 has nsswitch support.

The kernel module used should be autofs4.

The reason for the name is historic but autofs4 supports autofs kernel
protocols v3, v4 and v5 whereas the autofs module supports autofs kernel
protocol v3.

> 
> For now I've tried v5. However when starting automount I get some parse
> errors:
> 
> [...]
> --accepting rule at line 92 ("
> ")
> --accepting rule at line 92 ("
> ")
> --accepting rule at line 87 ("automount:")
> --accepting rule at line 95 (" ")
> --accepting rule at line 97 ("files")
> syntax error in nsswitch config near [ syntax error ]
> 
> My nsswitch.conf is attached below.
> 
> 
> It looks to me like the lexer ignoring everything until it reaches
> a ^automount line?

Well, yes it's looking for automount map sources, what else would you
expect?

> 
> Should I stick to the older automount version?

Don't think so. There's no nsswitch support in v4 and v4 is getting
limited attention these days.

> Maybe you can help me understand the problem so that I can try improving
> the error message?

Most of the time the message reflects the part of the line the message
occurred at but, if the parser gets an error at a point that doesn't
have text for the token it just prints the above.

The error handling in the lex/yacc (Flex/Bison actually) parser is
painful to the max. While that may well be my poor implementation the
fact that I ended up with a poor implementation after so much effort is
a problem in itself.

The question of whether to expand the use of a parser generator to the
rest of the parsing in autofs or to re-write the whole lot with a
manually crafted lexer and parser is still undecided.

> 
> I've built the 9a77464b git version.

Right, that's fairly recent.
The nsswitch.conf below looks OK to me and the parse works fine for me
here on an entry formatted the same way.

> 
> Thanks
> Marc Weber
> 
> My nsswitch.conf:
> 
> psswd:         ldap files
> group:          ldap files
> shadow:         ldap files
> 
> hosts:          files dns
> networks:       files dns
> 
> services:       files
> protocols:      files
> 
> automount: files nis
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
