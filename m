From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Space in Samba share
Date: Thu, 1 Apr 2004 15:42:32 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200404011542.32440.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org


How can I define a mount map that contains spaces in the share name
of a windows machine? 

I've tried some common ways of escaping the space to no avail.

-fstype .... etc \
	/local name //REMOTE/remote name

Sure I could skip the space in local name, so the real problem is the remote 
name.

-- robin
