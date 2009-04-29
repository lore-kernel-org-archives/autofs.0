From: Ian Kent <raven@themaw.net>
Subject: Re: Which version to uses, nsswitch.conf parse errors
Date: Wed, 29 Apr 2009 11:19:56 +0800
Message-ID: <49F7C75C.3070303@themaw.net>
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

This probably results from not having a <NL> at the end of the line.
It's not a simple matter to deal with this invalid input as we read the
nsswitch input from a stream and <EOF> needs to be handled by the parser
not the rules.

Ian
