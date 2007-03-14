From: Sascha Frey <sfrey@acs-software.de>
Subject: autofs5: multiple entries with wildcards
Date: Wed, 14 Mar 2007 22:20:55 +0100
Message-ID: <1173907255.8503.12.camel@prometheus.workstation.sash-bielefeld.net>
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

Hi,

I'm trying to set up autofs5, but I've got a problem:

auto.master:
/homes		/etc/auto.homes

auto.homes:
* -fstype=nfs,rw        homeserver1:/home/&
* -fstype=nfs,rw        homeserver2:/home/&

The directories on the first server are mounted. 
But if I try to access a home which is on the second one I get a 'No
such file or directory' error.


Thanks for any help.

- Sascha
