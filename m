From: Ian Kent <raven@themaw.net>
Subject: Re: Tokenizer in autofs broken
Date: Wed, 06 Jan 2010 10:59:47 +0800
Message-ID: <4B43FCA3.4070306@themaw.net>
References: <E1NS4eP-0005rM-IM@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1NS4eP-0005rM-IM@pomaz-ex.szeredi.hu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@linux.kernel.org, Peter Benie <pjb1008@cam.ac.uk>

On 01/05/2010 04:20 PM, Miklos Szeredi wrote:
> Forwarding this bug report:
> 
>   https://bugzilla.novell.com/show_bug.cgi?id=529416
> 
> Seems to affect the latest version with all patches applied.  The
> results are different though (notice the trailing spaces):

Yes, I've duplicated it.

> 
> stat("/etc/auto.profile      ", 0x7f9aebb9eb60) = -1 ENOENT (No such file or directory)

Yes, that is a result of the greedy match for the "multi" keyword or a
map type keyword.

> 
> The patch included in the report doesn't seem to help this.

No that's right, it doesn't deal with the trailing white space from the
greedy match.

I'll have a look at this.

> 
> Thanks,
> Miklos
> ----
> 
> The tokenizer (master_tok.l) uses a mixture of string and memory options in an
> unsafe way. As a result, entries can be corrupt when read if a string token
> follows a non-string token.
> 
> 
> Reproducible: Always
> 
> Steps to Reproduce:
> Create a map containing a string token:
> /auto           /etc/auto.auto          ro,hard,intr,nosuid,nodev
> /home           /etc/auto.home          rw,hard,intr,nosuid,nodev
> /profile        /etc/auto.profile       rw,hard,intr,nosuid,nodev
> 
> Actual Results:  
> /etc/auto.auto and /etc/auto.home load as expected.
> /etc/auto.profile is read as /etc/auto.proefil
> 
> If you miss out the auto.home map, /etc/auto.profile is read as
> /etc/auto.proofile.
> 
> There is the potential for a buffer overrun causing the automounter to crash.
> 
> 
> Expected Results:  
> Expected results are the the line is read as /etc/auto.profile.
> 
> 
> In the definition of <MAPSTR> in master_tok.l, there is the following code:
>     {MULTI} {
>         tlen = master_leng - 1;
>         if (bptr != buff && isblank(master_text[tlen])) {
>             strncat(buff, master_text, tlen);
>             bptr += tlen;
>             yyless(tlen);
>         } else {
>             strcpy(master_lval.strtype, master_text);
>             return(MULTITYPE);
>         }
>     }
> and later in the same block:
>     .    { *bptr++ = *master_text; }
> 
> When parsing /etc/auto.profile, the parser reads a sequence of characters into
>  the end of buff: /,e,t,c,/,a,u,t,o,.,p,r,o.
> 
> Then it reads 'file', as a single string token, concatenating it to the end of
> buff. buff is not NUL terminated. buff still contains data from the line above,
> so the string is copied to the end of that string. The number of characters
> written, bptr-buff, is maintained correctly, so the resulting string is
> truncated to the right number of characters.
