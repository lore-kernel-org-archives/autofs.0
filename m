From: Ian Kent <raven@themaw.net>
Subject: Re: sgi IRIX-6.5 autofs
Date: Thu, 7 Apr 2005 10:28:10 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504071025550.24138@wombat.indigo.net.au>
References: <20050403000945.GB22336@uio.no>
	<Pine.LNX.4.58.0504051957560.1851@donald.themaw.net>
	<20050405123425.GA20348@uio.no>
	<Pine.LNX.4.58.0504060958150.24274@wombat.indigo.net.au>
	<42543F39.3030105@rhythm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <42543F39.3030105@rhythm.com>
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
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

On Wed, 6 Apr 2005, Greg Bradner wrote:

> I have a situation on IRIX where I am stat'ing a filesystem that is not 
> exported to the IRIX system.  The syslog says 'permission denied'.  
> That's expected.  Since the directory I'm in has 600 links to the file 
> system that is not exported, autofs keeps trying to mount and keeps 
> getting 'permission denied'.
> 
> On linux I get 'permission denied', but it doesn't try to mount again 
> for 30 minutes.
> 
> Has anyone heard of such a problem with IRIX's autofs and is there a fix?
> Why does linux only try every 30 minutes?

I'm not sure why Linux is trying every thirty minutes.
There's not explicit retry login in autofs.

AFAIK it should only try to mount the target of the symlink when an access 
is attempted.

Ian
