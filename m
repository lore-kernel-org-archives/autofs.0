From: Mag Gam <magawake@gmail.com>
Subject: failed to mount offset
Date: Wed, 8 Jun 2011 05:06:21 -0500
Message-ID: <BANLkTinFxOHK1NMJfBy5bjHMpozM8oY9kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:date:message-id:subject:from:to
	:content-type; bh=xvns2xOB/phUyICjcmSJqPz2/27ziMLfdmw1QJFXnqQ=;
	b=t85xG65yxW0Fg4i07jVLyOUDlBm7W12WQDTisPU1sw8T48VklUapkLG/Fm2snDcwLX
	h/T7Irz/v3YuWlk4t388io2ssr6rkx4dyNKsGpBvn/LW1e5Ihcj62ilUBi4PCUPJZLAf
	bGeH7gZ5Qn47wINzIei52pkOp609Iisrp7UeE=
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
To: autofs@linux.kernel.org

Hello
Trying to mount a newly created volume on a fileserver (appliance) and
nis. Able to see the volume using showmount and able to mount so, I
don't believe its a permission problem.

The error I get is,

-zsh: cd: /net/appliance/newvol No such file or directory

kernel version:
2.6.18-238.el5


autofs version
autofs-5.0.1-0.rc2.143.el5_5.6.x86_64
Running RHEL 5.6 (Enterprise edition)


Autofs is in debugging mode but does not show up anything.


After I restart autofs many times I only see this message in syslog
(debugging enabled):
mount_multi_triggers: mount offset /net/appliancev/newvol at /net/appliance
failed to mount offset
