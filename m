From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] Maintain backwards compatibility w/ local file maps w/o
 etc.
Date: Fri, 22 Oct 2004 13:30:36 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410221329100.7438@wombat.indigo.net.au>
References: <1098291410.3527.18.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0410211040430.4454@wombat.indigo.net.au>
 <1098372523.9364.17.camel@gold.msp.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1098372523.9364.17.camel@gold.msp.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Thu, 21 Oct 2004, Chris Feist wrote:

> 
> > But this is a file map not a program map?
> 
> Yes, in the past (3.1.7 & 4.0.0) autofs would check for entries in the
> /etc/ directory even if it wasn't included in the auto.master file.
> 
> So, the following two files used to do the same thing:
> 
> File A:
> /home /etc/auto.home
> 
> File B:
> /home auto.home
> 
> So when people upgrade from 3.1.7 or 4.0.0 to 4.1.3 their maps end up
> breaking.

Point taken.

But the patch doesn't appear to fix that problem.
Can you explain?

Ian
