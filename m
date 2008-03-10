From: Ian Kent <raven@themaw.net>
Subject: Re: More directories?
Date: Mon, 10 Mar 2008 11:09:30 +0900
Message-ID: <1205114970.3025.19.camel@raven.themaw.net>
References: <47D4445E.10100@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47D4445E.10100@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org


On Sun, 2008-03-09 at 21:11 +0100, Stef Bon wrote:
> Hello,
> 
> some time now I've been experimenting with mounting smb shares. Now the 
> script
> auto.smb which comes with the autofs package, generates given a server, 
> all the shares.
> 
> ../server/share/<mounted samba share>
> 
> Thus, it creates one level deep paths. I'm wondering, is it possible to 
> create two or even more
> level deep directories with a script simular to auto.smb??

Its totally dependent on what is returned from the script.
The example script, auto.smb, just returns an entry with a multi-mount
offset for each share. If a more complex multi-mount is returned that
should work fine. The old auto.hosts would often return a more complex
multi-mount entry as NFS exports are often deeper than a single level.

Ian
