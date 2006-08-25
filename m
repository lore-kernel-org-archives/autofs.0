From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point to other	automount points
Date: Fri, 25 Aug 2006 22:46:03 +0800
Message-ID: <1156517163.30971.45.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
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
To: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

On Thu, 2006-08-24 at 15:44 +0100, Matt Bernstein wrote:
> Hi,
> 
> We like to preconfigure an number of our (1000ish) users' applications. 
> Typically, this might necessitate hard-coding their home directories in 
> dot-files, so we specify their home directory in the passwd map as 
> /homes/$LOGNAME, and make this an (LDAP) automount map which might point 
> to ":/server/{servername}/{volumename}/$LOGNAME" (via a bind mount), where 
> /server/{servername}/{volumename} would be the "real" NFS mount.

So you have another automount map for the server entries, right?

Ian
