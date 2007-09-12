From: "Wolfe, Allan" <Allan.Wolfe@anadarko.com>
Subject: Re: top level mount point
Date: Wed, 12 Sep 2007 13:17:45 -0500
Message-ID: <C9AD2899A176C0499022697035E7625A39EE17@houmbx5.anadarko.com>
References: <10badf220709110016w454badfdt31a82bf6142171cc@mail.gmail.com><1189502864.3585.10.camel@raven.themaw.net><46E6D684.7010808@schrodinger.com>
	<1189574773.3070.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1189574773.3070.11.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>, Simon Gao <gao@schrodinger.com>
Cc: autofs@linux.kernel.org

..
..
..
[trimmed to provide clarity]
..
..
..
>> Is there a good way to set up ldap entries so autofs 4 and 5 can each

>> find and match its own version of automount maps?

>The maps used with autofs v4 should all work with v5.
>If you find something that doesn't report it.

>> 
>> Many times, one has to run different versions of Redhat distributions

>> and not able to migrate to RHEL5 all together.

>Yes, and the other problem is mixed OS environments.

>One goal of v5 is to be able to be able to "fit in" with other
automount implementations, allowing a single set of map specifications.
I think we're well along in this regard so if you find a case where this
is broken report that too.

>Generally v4 maps need to include ldap information so this can't be
achieved with mixed v4 and v5 setups.

>For example, in v4, you usually need something like:

>automountInformation:  ldap://<server name>/ou=<map name>,<basedn>

>for all map entries. But in v5 it's generally best to use the map name
only such as:

>automountInformation:  <map name>

>and let the autofs work out the nsswitch source for the map.

>Ian

As an add-on from practical experience. . .  

I have found the "DAEMONOPTIONS='-Dvariable=value'" method in
/etc/sysconfig/autofs (RedHat) invaluable to maintain a consolidated
automap rather than one map per platform/version that is really serving
the same purpose, particularly for network shared binaries, libraries
and such. The map entries contain the variable embedded in the mount
information as a subdirectory name. Here is an example:

/etc/sysconfig/autofs (RedHat):
   DAEMONOPTIONS="-DOSV=rhel5_64"

/etc/default/autofs (Solaris 10):
   AUTOMOUNTD_ENV=MOPT=-rw,rsize=8192,wsize=8192,proto=tcp,intr,noquota
   AUTOMOUNTD_ENV=OSV=Sun_sparc

auto.master:
   /shared     auto_shared

auto_shared:
   bin     $MOPT host1:/export/shared/$OSV/bin
   lib     $MOPT host1:/export/shared/$OSV/lib
   etc     $MOPT host1:/export/shared/etc
   scripts $MOPT host1:/export/shared/scripts

On "host1" the file hierarchy would be:
   /export/shared/
     |- Sun_sparc/
        |- bin/
        |- lib/
     |- rhel5_64/
        |- bin/
        |- lib/
     |- etc/
     |- scripts/

On the UNIX systems, the mount options ($MOPT) are handled using the
"-D" option where in Linux we handle it directly in the auto.master.  On
Linux, since the $MOPT is not provided for in the configuration, it
resolves out to null and effectively is ignored. To the end user, the
path is always the same no matter what platform/version they are logged
into.  This helps to simplify (in one respect) scripting in a
multi-platform environment. 

The assumption/limitation here is that the volume storing the shared
files can be extended large enough to meet the requirements over all
platforms/versions.  For this application, it isn't a practical
limitation anymore; just a factor in planning.

_______________________________________________
-----------------------------------------

Anadarko Confidentiality Notice:  
This electronic transmission and any attached documents or other
writings are intended only for the person or entity to which it is
addressed and may contain information that is privileged,
confidential or otherwise protected from disclosure.  If you have
received this communication in error, please immediately notify
sender by return e-mail and destroy the communication. Any
disclosure, copying, distribution or the taking of any action
concerning the contents of this communication or any attachments by
anyone other than the named recipient is strictly prohibited.
