From: "Khor, Boon Pin" <boon.pin.khor@intel.com>
Subject: autofs4 issues
Date: Tue, 24 Jul 2007 07:03:13 +0800
Message-ID: <FB0EFEA980A6A1469DC5EB5DAE0BC7B703666DB0@pgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

Hi all  ,

  I have experiencing some inconsistency problem in autofs4 ( SLES9 SP3
, kernel is 2.6.5 ) ,  sometime the mount daemon just died unexpected ,
causing some mount point can not be mounted ( when cd to that directory
, it will have "no such file or directory ) , in fact , restart the
autofs daemon will caused some other mount point to be failed . I am
wondering , that is this problem the known issue in autofs4 ? if yes ,
is there any plan to back port the autofs5 to 2.6.5 ? the patch is only
available for 2.6.9 and above .

What is the pro and cons of using --ghost in autofs ? will it make the
client heavy loaded ? 

Thanks 
Boon Pin , Khor  
