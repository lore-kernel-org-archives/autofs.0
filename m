From: Ian Kent <raven@themaw.net>
Subject: Re: questions on auto.master file format
Date: Wed, 3 Mar 2004 14:56:33 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403031455220.16583@wombat.indigo.net.au>
References: <16452.51314.769206.991484@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16452.51314.769206.991484@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 2 Mar 2004, Jeff Moyer wrote:

> Hello,
> 
> Reading through Sun's documentation, it seems that mount options specified
> in auto.master should begin with a leading dash.  See the example here: 
>    http://docs.sun.com/db/doc/816-0211/6m6nc66nc?q=automount&a=view

What makes you think that?
Looks like the options are for the automounter not mount.

Ian
