From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: RE: Exporting UID to userspace?
Date: Wed, 9 Jun 2004 22:10:05 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3841AA@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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

> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> 
> If the idea is to have a 'Network Neighborhood' inside each 
> user's homedir, you could write an executable map for /home 

It will hide /home directory content.

> (not tested..):

> key = shift
Did you mean key=$1 ?

> entry = `ypcat $KEY -k`
What did you mean for $KEY? What is supposed to assign to the 'entry'
variable?

> if [ $? == 0 ] ; then
>    echo $entry " /NetworkNeighborhood -Duser=$key /etc/auto_nn"
>    exit 0
> fi;
> exit 1
> 
> And then use a auto_nn executable map for generating the 
> Neighborhood contents.
