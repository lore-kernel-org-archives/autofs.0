From: jmoyer@redhat.com
Subject: Re: Strange issue with autofs5/fc6
Date: Mon, 23 Apr 2007 14:01:00 -0400
Message-ID: <m3odlfj7hf.fsf@redhat.com>
References: <46264599.90105@kmaclub.com>
	<x49zm4zni6f.fsf@segfault.boston.devel.redhat.com>
	<462CEB64.2020103@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <462CEB64.2020103@kmaclub.com> (michael@kmaclub.com's message of
	"Mon, 23 Apr 2007 10:22:44 -0700")
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
To: Michael <michael@kmaclub.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] Strange issue with autofs5/fc6; Michael <michael@kmaclub.com> adds:

michael> Jeff Moyer wrote:
>> ==> On Wed, 18 Apr 2007 09:21:45 -0700, Michael <michael@kmaclub.com>
>> said:
>> 
michael> The 262144 size is strange and I don't have any idea where that is
michael> coming from.
>> Can you send along an automount debug log?  Perhaps automount is not
>> passing the [rw]size parameters to mount.  For information on gathering
>> debug logs, see: http://people.redhat.com/jmoyer/
>> 

michael> I will go capture the logs.  However, it does appear to be a
michael> kernel/mount issue.

michael> If I do the mount by hand and not using autofs it still has the
michael> same problem.

michael> root@client /]# mount -o
michael> rsize=16384,wsize=16384,proto=tcp,timeo=600,retrans=2
michael> filer:/export /mnt

michael> mount | grep mnt filer:/export on /mnt type nfs
michael> (rw,rsize=16384,wsize=16384,proto=tcp,timeo=600,retrans=2,addr=192.168.101.1)

michael> grep mnt /proc/mounts filer:/export /mnt nfs
michael> rw,vers=3,rsize=262144,wsize=262144,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=filer
michael> 0 0

michael> So I don't know if it is just reporting incorrectly or if it is
michael> actually mounted incorrectly.

Oh, I somehow missed that.

michael> I will also open an issue on bugzilla for fc6.

OK, it's probably best to use component kernel and assign it to
steved@redhat.com.

-Jeff
