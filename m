From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP-based auto.master and --ghost option
Date: Tue, 03 Oct 2006 01:18:59 +0800
Message-ID: <1159809539.2905.12.camel@raven.themaw.net>
References: <Pine.CYG.4.64.0609291328430.468@ninja>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.CYG.4.64.0609291328430.468@ninja>
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
To: Robert Giles <rgiles@arlut.utexas.edu>
Cc: autofs@linux.kernel.org

On Fri, 2006-09-29 at 14:20 -0500, Robert Giles wrote:
> Hi folks - I have our auto.master configuration stored in LDAP as an 
> "nisMap", with "nisObjects" beneath it describing our various mount 
> points.  I'm trying to get the --ghost option to work from this LDAP-based 
> auto.master, but am not having any luck (the mounts DO work without the 
> --ghost option).
> 
> This is on a SuSE 10.1-based system, running autofs 4.1.4 and the 2.6.18 
> vanilla kernel (with SuSE 10.1 /proc/config.gz)...
> 
> 
> For example, one of my working nisObjects under the auto.master:
> 
>           cn=/proj
> nisMapEntry=ldap:nisMapName=auto.proj,ou=autofs,dc=fake
> 
> 
> ...would report this line from "Configured Mount Points" after starting 
> autofs (and also as an active mount point):
> 
> /usr/sbin/automount /proj ldap "nisMapName=auto.proj,ou=autofs,dc=fake"
> 
> ...
> 
> When I add the --ghost option to my nisMapEntry...
> 
>           cn=/proj
> nisMapEntry=ldap:nisMapName=auto.proj,ou=autofs,dc=fake --ghost

This should be correct but obviously not.

> 
> 
> ...I get this back when starting autofs (and the mount point is 
> missing from the "active" mounts list):
> 
> /usr/sbin/automount /proj ldap:nisMapName=auto.proj,ou=autofs,dc=fake "--ghost"

And should end up like:

/usr/sbin/automount --ghost /proj ldap nisMapName=auto.proj,ou=autofs,dc=fake

> 
> The quotes appear to shift over to the "--ghost" option, and the 
> ldap:nisMapName is no longer parsed correctly (ie: split on the ":" 
> separator).
> 
> Seems like I'm using invalid syntax when specifying additional automount 
> options via the nisMapEntry field...  can anyone shed some light on what 
> I'm doing wrong here?
> 
> (I've also tried adding the "--ghost" before the "ldap:nisMapName..." 
> string, without success)
> 
> Thanks for any tips out there.

This has to be the init script or the ldap master map parser program.
I'll have a look when I get a chance.

Ian
