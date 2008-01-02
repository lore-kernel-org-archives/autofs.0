From: Ian Kent <raven@themaw.net>
Subject: Re: How does autofs know when the maps have changed?
Date: Wed, 02 Jan 2008 10:51:29 +0900
Message-ID: <1199238690.3072.6.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F0519299F@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F0519299F@permls05.wde.woodside.com.au>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

On Wed, 2008-01-02 at 07:12 +0900, Coe, Colin C. (Unix Engineer) wrote:
> Hi all
> 
> We have a mix of Linux and Solaris workstations and servers.  In Solaris
> land, an 'automount -v' is run nightly to pickup any changes to the
> automount maps.  Is this required with the autofs distributed by RedHat?
> Does autofs do any checking to see if the map has changed? We're running
> RedHat EL 3, 4 and 5, (mostly) fully patched.

Basically, yes and no!

There are some differences between version 4 and version 5 but below is
generally the case.

For indirect maps it should see changes but a HUP signal can be used to
force an update.

For direct maps you need to send a HUP signal to the daemon.

A "service autofs reload" will do this. But be aware that RHEL 5.1 has a
bug that can cause it to wipe out the map under some circumstances.

Ian
