From: Richard Ray <rray@mstc.state.ms.us>
Subject: Reducing logging
Date: Tue, 30 Jan 2007 09:22:07 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0701300915430.24938@rray.drdc.mstc.ms.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

I would like to reduce the amount of info that automount logs
My system log is full of

Jan 30 09:16:03 qgb automount[16694]: >> mount: dev:/sql/include failed, reason given by server: Permission denied
Jan 30 09:16:03 qgb automount[16694]: mount(nfs): nfs: mount failure dev:/sql/include on /net/dev/sql/include

The automount man page does not say what syslog facility it uses
If it uses daemon how can I reduce logging from automount and not all daemons

Thanks
Richard
