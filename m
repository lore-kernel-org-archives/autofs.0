From: "Rajouri Jammu" <rajouri.jammu@gmail.com>
Subject: wait_for_lock() in mount
Date: Fri, 18 Apr 2008 09:39:33 -0700
Message-ID: <3307cdf90804180939t42fed2d7k8fc96304f8d01455@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4573859342200604953=="
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

--===============4573859342200604953==
Content-Type: multipart/alternative; 
	boundary="----=_Part_5575_16162691.1208536773382"

------=_Part_5575_16162691.1208536773382
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I'm trying to bring up a stacked file system on top of an NFS mount point
both via automount.

For example:
On my client system I have two directories /data1 and /data2
/data1/nfs_01
/data2/nfs_01

nfs_server:/data/nfs_01 is mounted on /data1/nfs_01 (type nfs)

/data1/nfs_01 is mounted on /data2/nfs_01

The automount config files look like:
/etc/auto.data1:
nfs_01   nfs_server:/data/nfs_01

/etc/auto.data2:
nfs_01   -fstype=ecryptfs :/data1/nfs_01


The problem:

When I try to access /data2/nfs_01 it kicks in automount to mount
/data1/nfs_01, which in turn kicks in automount again to mount
nfs_server:/data/nfs_01 on /data1/nfs_01.

The second mount waits for 10secs for a lock file held by the first mount in
mount_nfs.c after mkdir_path().

Is there a way I can configure things such that the second mount doesn't
wait?

The lock file is a single global.
Should the file be specific to the mount point?

Any help would be appreciated.

Thanks,

------=_Part_5575_16162691.1208536773382
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="Apple-style-span" style="border-collapse: collapse; ">Hi,<div><br></div><div>I&#39;m trying to bring up a stacked file system on top of an NFS mount point both via automount.</div><div><br></div><div>For example:</div>
<div>On my client system I have two directories /data1 and /data2</div><div>/data1/nfs_01</div><div>/data2/nfs_01</div><div><br></div><div>nfs_server:/data/nfs_01 is mounted on /data1/nfs_01 (type nfs)</div><div><br></div>
<div>/data1/nfs_01 is mounted on /data2/nfs_01</div><div><br></div><div>The automount config files look like:</div><div>/etc/auto.data1:</div><div>nfs_01 &nbsp; nfs_server:/data/nfs_01<br></div><div><br></div><div>/etc/auto.data2:</div>
<div><div>nfs_01 &nbsp; -fstype=ecryptfs :/data1/nfs_01</div><div><br></div><div><br></div><div>The problem:</div><div><br></div><div>When I try to access /data2/nfs_01 it kicks in automount to mount /data1/nfs_01, which in turn kicks in automount again to mount nfs_server:/data/nfs_01 on /data1/nfs_01.</div>
<div><br></div><div>The second mount waits for 10secs for a lock file held by the first mount in mount_nfs.c after mkdir_path().</div><div><br></div><div>Is there a way I can configure things such that the second mount doesn&#39;t wait?<br>
</div><div><br></div><div>The lock file is a single global.<br></div><div>Should the file be specific to the mount point?</div><div><br></div><div>Any help would be appreciated.</div><div><br></div><div>Thanks,</div><div>
<br></div></div></span>

------=_Part_5575_16162691.1208536773382--


--===============4573859342200604953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4573859342200604953==--

