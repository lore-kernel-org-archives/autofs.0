From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Exporting UID to userspace?
Date: Tue, 08 Jun 2004 14:45:24 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40C60944.3080006@sun.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841A3@frodo.avalon.ru>
 <Pine.LNX.4.58.0406080901490.17060@wombat.indigo.net.au>
 <1086700328.20393.38.camel@brilong-lnx2.cisco.com>
 <Pine.LNX.4.58.0406090017110.22861@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0406090017110.22861@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

raven@themaw.net wrote:
> On Tue, 8 Jun 2004, Brian Long wrote:
>
>
>>>Fact is I'm still struggling to get bugs fixed. When that has settled
down
>>>there are a couple of quite serious limitations with autofs that need to
>>>be addressed. They've been outstanding for many months.
>>
>>Ian,
>>
>>Could you remind us what "serious limitations" still exist in autofs?
>>Is this in comparison to Sun's implementation on Solaris or something
>>else?
>
>
> Lazy mounting of multi-mount map entries.
> Direct mounts obscure underlying file system high up in the tree.
>
> Yes this is what people expect from an automounter as Suns implementation
> provides it. In any case I've needed it for ages and I have some fairly
> clear ideas on how to implement it, after having given it much thought.
>
> Don't get me wrong here, the big issue with this request is working out a
> way to get hold of the UID and GID or perhaps GIDs without having to
> compromise the existing system.
>
> Do you guys have any ideas on how we might do this?
>
> Ian

If the idea is to have a 'Network Neighborhood' inside each user's
homedir, you could write an executable map for /home (not tested..):

key = shift
entry = `ypcat $KEY -k`
if [ $? == 0 ] ; then
   echo $entry " /NetworkNeighborhood -Duser=$key /etc/auto_nn"
   exit 0
fi;
exit 1

And then use a auto_nn executable map for generating the Neighborhood
contents.

To handle mounting with credentials, you'll have to

a) adapt the existing modules to handle grabbing credentials

or

b) write a generic 'execmount' module that will execute a given script
with all the required information (all the environment variables, mount
options, real filesystem type, yadda yadda).   This is my preferred
approach to handling this as it can be re-used for other strange
automount uses..

This method also means that you don't have to touch the kernel module at
all..

What think?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxglEdQs4kOxk3/MRAl0jAJ9NzCQq0c4AZ8r2DupTP2hilZ6CXQCeIWKu
hEQ6VbhSVaURsqIPW9tRboM=
=CzDF
-----END PGP SIGNATURE-----
