From: Chuck Lever <chuck.lever@oracle.com>
Subject: Thoughts on dynamic networking with AutoFS/NFS
Date: Mon, 20 Jun 2011 11:05:15 -0400
Message-ID: <103B6C15-D8E4-4344-A365-E9D9E04100A5@oracle.com>
References: <mailman.1.1308484801.6410.autofs@linux.kernel.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <mailman.1.1308484801.6410.autofs@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Colin Simpson <Colin.Simpson@iongeo.com>
Cc: autofs@linux.kernel.org


> From: Ian Kent <raven@themaw.net>
> 
> On Thu, 2011-06-16 at 20:20 +0100, Colin Simpson wrote:
>> Hi
>> 
>> I was just wondering what the thoughts (maybe plans) are for making
>> autofs/nfs more dynamic in the new world of dynamic networking with
>> the likes of Network Manager now being the default.
> 
> I've read this a couple of times now and I'm still not sure what to say
> because the mail is so open ended. But here are a few comments anyway.
> 
> That might mean dbus integration which I've tried to avoid because, to
> me, that looks really painful and AFAICT the documentation is lousy so
> working out what the hell to do is difficult and frustrating.
> 
> But that's not really the largest part of the work either, which I won't
> try and go into now, because of the main difficulty described below.
> 
>> 
>> We now have quite a few users with linux laptops and they want to see
>> the standard automounts on these. But being laptops they frequently
>> switch subnet, jump on WiFi and VPN etc. 
>> 
>> Most subsystems seem to play pretty well with this dynamic network
>> environment and are hooked into NM (with SSSD doing a good job with
>> off net credentials and directory services caching)
>> 
>> Now I know that autofs/nfs is a much harder nut to crack given its
>> heavy in kernel component, but I'd have thought the present
>> non-dynamic behaviour is a bit of an anomaly. 
> 
> The issue is NFS.
> 
> Dynamic fail-over for mounts has been on the NFS list of things to do
> for over five years and is not done yet. I'm not even sure anything is
> being done or has been done toward it. And that's just for the simpler
> case of read-only mounts.
> 
> I'm not sure that is what your after either but the difficulty would be
> considerably more for read-write mounts. For example, although nfs
> mounts are stateless (nfs4 is another matter entirely), they rely on a
> file handle that is constructed based on server dependent information so
> moving from one network to another and expecting mounts to just continue
> to work is not going to be simple, if it is even possible.

For more information on NFS plans in this area, Colin, you could post your questions to linux-nfs@vger.kernel.org.  The NFS version 4 protocol provides lots of opportunities for client-side fail-over support, even for read/write mounts.  We're working on some of these pieces now, but it will be a while.

The question of NFSv3 client-side fail-over support is more sticky, as Ian has pointed out.

-- 
Chuck Lever
chuck[dot]lever[at]oracle[dot]com
