From: Ian Kent <raven@themaw.net>
Subject: Re: automount doesn't reread file map, automount terminates
 on empty file map
Date: Wed, 15 Dec 2004 18:08:44 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0412151807070.30726@wombat.indigo.net.au>
References: <1102796222l.6265l.2l@mercury>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1102796222l.6265l.2l@mercury>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Jahns <Thomas.Jahns@gmx.net>
Cc: autofs@linux.kernel.org

On Sat, 11 Dec 2004, Thomas Jahns wrote:

> Hi,
> 
> I'm currently experimenting with a script-created map and face the  
> following two problems:
> 
> - After the script rewrites the map, I need to kill -HUP the  
> corresponding automount to reread the map, the documentation says the  
> daemon would read a changed map on next access of the directory?

Known problem with 4.1.
But what vesion are you running?

> 
> - Unfortunately there exists the possibility, that the script might  
> leave the map empty. The corresponding automount process will then  
> exit. Is there perhaps some comment convention or anything else I could  
> do to keep the automount process running?

Known problem but not yet fixed.

Ian
