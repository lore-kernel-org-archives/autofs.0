From: Stef Bon <stef@bononline.nl>
Subject: Re: More directories?
Date: Mon, 10 Mar 2008 08:15:08 +0100
Message-ID: <47D4DFFC.8010705@bononline.nl>
References: <47D4445E.10100@bononline.nl>
	<1205114970.3025.19.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1205114970.3025.19.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> Its totally dependent on what is returned from the script.
> The example script, auto.smb, just returns an entry with a multi-mount
> offset for each share. If a more complex multi-mount is returned that
> should work fine. The old auto.hosts would often return a more complex
> multi-mount entry as NFS exports are often deeper than a single level.
>
> Ian
>
>   
Ok, That's clear. I know that's it's the script which should return it.

What I want to know is, is it possible to use mountpoint's like:

../<USER>/server/share/<mounted smb share>

A multimount with the first key the <USER>.

Stef Bon
