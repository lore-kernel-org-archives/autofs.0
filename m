From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Program map and submount problem
Date: Fri, 23 Jan 2004 20:25:28 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <56E74918-4E25-11D8-9520-000A95A011F0@qualcomm.com>
References: <200401232038.i0NKc9pK019108@miguelito.qualcomm.com>
	<Pine.LNX.4.58.0401241101370.1751@raven.themaw.net>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401241101370.1751@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On Jan 23, 2004, at 7:19 PM, raven@themaw.net wrote:

FYI, in case you missed them due to your ISP's mailserver issues.. I 
posted a few more messages today with more info.  They're in the list 
archives.

> The program must return a valid map. What does it return when you run 
> it
> manually with expected inputs. eg. auto.projects.sh bin.

The program works exactly like expected, and has been working for quite 
some time.  This is either a problem that didn't exist before, or we 
just somenow never triggered it before.

I found out that if you just cd into the path and sit there, it'll trip 
the bug, no need to have one of the NFS mounts below it triggered at 
all.

> That's probably not going to help much but worth a try.

Yeah, didn't do anything.  I don't think it does anything as is so 
taking it out probably won't matter.

> Ah. You don't mean submount in the sence I think of it. When you say
> submount I think of the mount itself being an autofs mount. Lets call
> these normal automounts.
>

Actually, that is what I mean.  If I'm reading you right.  To help 
clear it up, the map has entries:
/usr/local/projects/some/automount/submount/bin     
netapp:/vol/vol0/submount_bin
/usr/local/projects/some/automount/submount/lib     
netapp:/vol/vol0/submount_lib
/usr/local/projects/some/automount/submount/tools     
netapp:/vol/vol0/submount_tools

It's at the /usr/local/projects/some/automount/submount (or even just 
/usr/local/projects/some/automount or /usr/local/projects/some) is 
where the bug happens.  We have a huge direct mount map 1800+ entries, 
with many cases like the above.

> It appears you are using 4.1.0 but what kernel module?

using kernel protocol version 4.04

> The bottom line is that I will need to duplicate the problem in order 
> to
> solve it. If you are willing to provide the script it may be easier 
> for me
> to do that. Otherwise I'm in the dark about what is actually going on.

Sure... nothing proprietary in the script.  I made some additions 
awhile back that adds rsize= and wsize= options, also checks server for 
tcp support and uses if available (we had huge performance hits when 
crossing routers to our netapp filers when using udp, using tcp fixed 
it, the mount I've been doing testing of this bug on is mounted over 
udp).  Note that the same jim in the script submitted a patch to the 
list here back in '01 that is required in order for our script to work 
right.

Here's the patch (lines are from old automount.c file though, so 
location is several lines farther down):
*** automount.c Thu Apr 19 10:08:10 2001
- --- automount.c.orig  Thu Apr 19 09:45:37 2001
***************
*** 990,998 ****
         close(ap.state_pipe[0]);
         close(ap.state_pipe[1]);

- -       /* 04/19/01 --  Added by jbar to allow program mounts to 
determine
- -          in what directory the key is being looked up. */
- -       chdir(ap.path);
         err = ap.lookup->lookup_mount(ap.path, pkt->name, pkt->len,
                                     ap.lookup->context);

- --- 990,995 ----

Note that patch and the script work fine for making mounts, and the bug 
is only tripped if a daemon tries to exit after umounting the last 
directory below it but it's directory itself is busy.

#!/bin/sh

# Look for direct map entries of the form $(pwd)/$key in
# auto.projects file map.
#
# If there is an exact match, return the results of the match.
#
# If there are records that begin with $(pwd)/$key/ then return a
# submount entry, with the map being a program map that points back to
# this script
#
# Jim Barbour -- Qualcomm IT    04/19/01
#

PATH=/bin:/sbin:/usr/bin:/usr/sbin
export PATH

# echo "$$ `/bin/date` ARG: $*" >> /tmp/env
# echo "$$ `/bin/date` ENV: $(env | grep -i pref)" >> /tmp/env
# echo "$$ `/bin/date` PWD: $(/bin/pwd)" >> /tmp/env

# It appears that pwd is always the parrent of what you're looking up,
# even if you're not doing a cd.

# If we match exactly, then the match is printed and we exit.
#/usr/bin/gawk -v "m=$(/bin/pwd)/$*" '$1 == m {
#result=`/usr/bin/gawk -v "m=/usr/local/projects/vlsi/$*" '$1 == m {
result=`/usr/bin/gawk -v "m=$(/bin/pwd)/$*" '$1 == m {
                                         found = $2"MNT_OPTS " $3
                                         exit
                                 }
                                 m "/" == substr($1,0,length(m) + 1) {
                                         partial=1
                                 }
                                 END {
                                         if (found != "")
                                         {
                                                 printf "%s\n", found
                                                 exit 0
                                         }
                                         else if (partial == 1)
                                         {
                                                 exit 1
                                         }
                                         else
                                         {
                                                 exit 2
                                         }
                                 }' /etc/auto.projects`
if [[ $? -eq 0 ]]; then
   filer=`echo $result | awk '{print $NF}' | awk -F: '{print $1}'`
   /usr/sbin/rpcinfo -t $filer nfs 3 > /dev/null 2>&1
   if [[ $? -eq 0 ]]
   then
     result=`echo $result | sed -e 
's/MNT_OPTS/,tcp,rsize=32768,wsize=32768/g' -e 's/proto=udp,//g'`
   else
     result=`echo $result | sed 's/MNT_OPTS/,rsize=2048,wsize=8192/g'`
   fi
   echo $result
   exit 0;
elif [[ $? -eq 1 ]]; then
         # Yes we are, output an autofs map that calls the script
         # for all lookups.
         echo "-fstype=autofs,-Dpref=$key program:/etc/auto.projects.sh 
$key"
         exit 0
fi

# This is not an exact match, not in the middle of a nested mount, so
# give back an error.
exit 1

-
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Drew: "Violence doesn't solve anything? World War I. World War II. Star 
Wars.
every Super Bowl. Who says violence doesn't solve anything?!" ==> Drew 
Cary Show
