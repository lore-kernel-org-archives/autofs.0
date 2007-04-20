From: Ian Kent <raven@themaw.net>
Subject: Re: Allow period in -Dvariable=value flags in auto.master
Date: Fri, 20 Apr 2007 13:01:01 +0800
Message-ID: <1177045261.3934.59.camel@raven.themaw.net>
References: <40ddc4e40704191355w360b3e3bj6fa6615d6c3defa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40ddc4e40704191355w360b3e3bj6fa6615d6c3defa0@mail.gmail.com>
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
To: Mike Matera <spamme@fatboycentral.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-04-19 at 13:55 -0700, Mike Matera wrote:
> Hi,
> 
> In order to use autofs on my company network I must override OSNAME,
> ARCH and OSREL to match other Linux boxes.  Previous automount allowed
> the following line in auto.master:
> 
> /stuff yp:auto.stuff -DOSNAME=Linux -DARCH=i686 -DOSREL=2.4
> 
> This stopped working on my FC6 box (autofs-5.0.1-0.rc3.10) because the
> parser choked on the '.' in 2.4.  I couldn't find anyone else who'd
> run into this problem so I made a patch to master_tok.l that allows
> periods in the variable values.
> 
> All I did was add '\.' to the character class on the right side of the
> equal sign in the MACROSTR rule.  The code is shown below:
> 
> MACROSTR (-D{OPTWS}([[:alpha:]_]([[:alnum:]_\-])*)=([[:alnum:]_\-\.])+)

Ha .. an obvious omission on my part.
Will fix, thanks.

I wonder why others haven't seen this?
I'm sure a lot of people use macros like this.

Ian
