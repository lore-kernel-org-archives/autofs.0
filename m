From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: fast mounting problems
Date: Tue, 14 Sep 2004 10:42:29 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16711.853.857601.846914@segfault.boston.redhat.com>
References: <E1C2Bv4-0002u8-7T@www.linux.org.uk>
	<Pine.LNX.4.58.0409041404480.8861@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409041404480.8861@donald.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, Bryce as root <root@www.linux.org.uk>

==> Regarding Re: [autofs] fast mounting problems; raven@themaw.net adds:

raven> On Tue, 31 Aug 2004, Bryce as root wrote:
>> Relating to Autofs 4.1
>> 
>> This relates to a bug I've filed with RHAT (
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966 )
>> 
>> In our testing enviroment we use autofs a lot and have been experiancing
>> problems of being unable to mount directories every now and again
>> 
>> To this end I build a test script to exercise the autofs daemon which
>> nicely exposes the problem (again covered in the bugzilla report)
>> 
>> What appears to be happening is that autofs is spawning forked copies of
>> itself to help facilitate loading FS's however, initially when debugging
>> it seemed like the first batch of NFS directories were mounted before
>> the second forked process times out trying to rpc_ping the server
>> because the initial process never bothered to close the socket.
>> 
>> Now Jeff Moyer at RedHat spotted that and gave me a patch for
>> rpc_stubs.c which alleviates the problem slightly, however, while the
>> parent and then the first child process play nice, any further forked
>> processes also run into this rpc_ping port being held open and
>> consequently fail to mount and you'd see something like this in the
>> system messages log
>> 
>> Aug 18 18:59:12 localhost automount[8746]: attempting to mount
>> entry/test/947 Aug 18 18:59:12 localhost automount[9050]: >> nfs
>> bindresvport: Address already in use Aug 18 18:59:12 localhost
>> automount[9050]: mount(nfs): nfs: mount failure
>> 192.168.1.100:/compile/nfs/947 on /test/947
>> 
>> soooooo,.... ideas on how to make the other children processes play
>> nice?

raven> I've read the bugzilla report.

raven> Thanks for you huge effort in profiling this problem Phil.

raven> After investigating it looks like Jeffs' original patch was not
raven> quite right. Can you try the attached patch and let me know how it
raven> goes please. It assumes that Jeffs' original sock leak fix patch has
raven> been applied.

Hi, Ian,

OK, so I've finally gotten 'round to looking at your patch.  You can avoid
including internal rpc data structures by using the clnt_control call with
CLSET_FD_CLOSE.  Aside from that, I like your approach better.  ;)  So, how
about this patch instead of the other two?

-Jeff

--- autofs-4.1.3/lib/rpc_subs.c~	2004-09-14 10:32:30.000000000 -0400
+++ autofs-4.1.3/lib/rpc_subs.c	2004-09-14 10:36:29.766803120 -0400
@@ -48,7 +48,7 @@ struct conn_info {
  */
 static CLIENT* create_udp_client(struct conn_info *info)
 {
-	int fd = -1;
+	int fd = RPC_ANYSOCK;
 	CLIENT *client;
 	struct sockaddr_in addr;
 	struct hostent *hp;
@@ -169,6 +169,7 @@ static CLIENT* create_tcp_client(struct 
 	if (!client)
 		goto out_close;
 
+	clnt_control(client, CLSET_FD_CLOSE, NULL);
 	return client;
 
 out_close:
