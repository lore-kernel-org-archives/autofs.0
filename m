From: Ian Kent <raven@themaw.net>
Subject: Re: embedded spaces in automounter map options field
Date: Wed, 18 Aug 2004 17:23:49 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408181723030.15856@wombat.indigo.net.au>
References: <200408171008.26436.gmishkin@acs.bu.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200408171008.26436.gmishkin@acs.bu.edu>
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
To: gmishkin@bu.edu
Cc: autofs@linux.kernel.org

On Tue, 17 Aug 2004, Geoff Mishkin wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have a situation that requires me to have embedded spaces in the options 
> field of my automounter map.  To make things trickier, the map has to be 
> generated with an executable map.  I am using shfs and have to use it's cmd 
> mount option to force it to connect using a specific private key file.  This 
> requires there to be embedded spaces in the options field, like this:
> 
> - -fstype=shfs,cmd="ssh -i /usr/keys/<username> <username>@<host>"
> 
> Which causes the automounter to complain bitterly.  Most of the information 
> I've found is for having spaces in share names or mount points, but the 
> advice given doesn't work in the options field.  I've tried all kinds of 
> quotes, backslashing, etc.  I'd greatly appriciate help.
> 
> Please CC me on replies as I am not subscribed to the list.

You don't say which version of autofs you are using?

Ian
